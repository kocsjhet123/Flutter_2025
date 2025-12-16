import 'package:flutter/material.dart';
import 'package:flutter_api/api.dart';
import 'package:flutter_api/model/product.dart';

class ProductApi extends StatefulWidget {
  const ProductApi({super.key});

  @override
  State<ProductApi> createState() => _ProductApiState();
}

class _ProductApiState extends State<ProductApi> {
  List<Product> _allProducts = [];
  bool _loading = true;
  String? _error;

  bool _searchMode = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await Api().getAllProducts();
      setState(() {
        _allProducts = products;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  List<Product> get _filteredProducts {
    if (_searchQuery.isEmpty) return _allProducts;
    return _allProducts.where((p) {
      return p.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = width >= 900 ? 4 : 3;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Danh Sách Sản Phẩm",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, anim) =>
                  FadeTransition(opacity: anim, child: child),
              child: _searchMode
                  ? Container(
                      key: const ValueKey("searchBar"),
                      width: 200,
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Tìm...",
                          border: InputBorder.none,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = '';
                                _searchMode = false;
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        onChanged: (v) {
                          setState(() => _searchQuery = v);
                        },
                      ),
                    )
                  : IconButton(
                      key: const ValueKey("searchIcon"),
                      onPressed: () {
                        setState(() => _searchMode = true);
                      },
                      icon: const Icon(Icons.search, size: 26),
                    ),
            ),
          ),
        ],
      ),

      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text("Lỗi: $_error"))
          : _filteredProducts.isEmpty
          ? const Center(child: Text("Không có sản phẩm"))
          : Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.55,
                ),
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  return productCard(_filteredProducts[index]);
                },
              ),
            ),
    );
  }

  Widget productCard(Product p) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductDetail(product: p)),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  p.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_not_supported, size: 40),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "\$${p.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        for (int i = 1; i <= 5; i++)
                          Icon(
                            i <= p.rate.round()
                                ? Icons.star
                                : Icons.star_border,
                            size: 14,
                            color: Colors.amber,
                          ),
                        const SizedBox(width: 4),
                        Text(
                          "(${p.count})",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================
//  PRODUCT DETAIL SCREEN
// ==========================

class ProductDetail extends StatelessWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.image,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_not_supported, size: 100),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              product.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 22,
                color: Colors.green,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                for (int i = 1; i <= 5; i++)
                  Icon(
                    i <= product.rate.round() ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 20,
                  ),
                const SizedBox(width: 8),
                Text(
                  "${product.rate.toStringAsFixed(1)} • ${product.count} đánh giá",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Danh mục: ${product.category}",
                style: const TextStyle(fontSize: 14),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Mô tả sản phẩm",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              product.description,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
