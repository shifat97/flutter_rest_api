import 'package:flutter/material.dart';
import 'package:flutter_rest_api/rest_api/rest_client.dart';
import 'package:flutter_rest_api/styles/styles.dart';
import 'package:flutter_rest_api/views/product_create_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // create a object of rest_client
  RestClient restClient = RestClient();

  List productList = [];
  bool isLoading = true;

  @override
  void initState() {
    callData();
    super.initState();
  }

  callData() async {
    isLoading = true;
    var data = await restClient.productReadRequest();

    setState(() {
      productList = data;
      isLoading = false;
    });
  }

  void deleteItem(String id, int index) {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete'),
        content: const Text('Do you want to delete?'),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              restClient.deleteProductRequest(id);
              setState(() {
                productList.removeAt(index);
              });
            },
            child: const Text('Yes'),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
        ],
      );
    });
  }

  void moveToCreateProductPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCreateScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.colorGreen,
        title: const Text(
          'List Product',
          style: TextStyle(
            color: AppStyles.colorWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              onPressed: () {
                moveToCreateProductPage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStyles.colorWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text('Create Product', style: TextStyle(
                color: AppStyles.colorGreen,
              ),),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            child: isLoading ? Center(
              child: CircularProgressIndicator(),
            ) : RefreshIndicator(
              child: GridView.builder(
                itemCount: productList.length,
                gridDelegate: AppStyles.productGridView(),
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            productList[index]['Img'],
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 7),
                              Text(
                                productList[index]['ProductName'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text('Price: \$${productList[index]['UnitPrice']}'),
                              const SizedBox(height: 7),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      moveToCreateProductPage();
                                    },
                                    child: Icon(
                                      Icons.edit_note,
                                      color: AppStyles.colorGreen,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      deleteItem(productList[index]['_id'], index);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: AppStyles.colorRed,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              onRefresh: () async {
                await callData();
              },
            ),
          ),
        ],
      ),
    );
  }
}
