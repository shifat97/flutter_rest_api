import 'package:flutter/material.dart';
import 'package:flutter_rest_api/rest_api/rest_client.dart';
import 'package:flutter_rest_api/styles/styles.dart';
import 'package:flutter_rest_api/utils/utils.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  // created a rest_client object
  RestClient restClient = RestClient();

  Map<String, String> formData = {
    'Img': 'https://www.reviews.org/app/uploads/2020/10/IMG_0970.jpg',
    'ProductCode': 'Realme101',
    'ProductName': 'Realme 6',
    'Qty': '',
    'TotalPrice': '200',
    'UnitPrice': '200',
  };

  bool isLoading = false;

  void inputOnChange(String key, String textValue) {
    setState(() {
      formData.update(key, (value) => textValue);
    });
  }

  void formOnSubmit() async {
    if (formData['ProductName'] == '') {
      AppUtils.errorToast('Product name required');
    } else if (formData['ProductCode'] == '') {
      AppUtils.errorToast('Product code required');
    } else if (formData['Img'] == '') {
      AppUtils.errorToast('Image link required');
    } else if (formData['UnitPrice'] == '') {
      AppUtils.errorToast('Unit price required');
    } else if (formData['TotalPrice'] == '') {
      AppUtils.errorToast('Total price required');
    } else if (formData['Qty'] == '') {
      AppUtils.errorToast('Quantity required');
    } else {
      setState(() {
        isLoading = true;
      });

      await restClient.productCreateRequest(formData);

      setState(() {
        isLoading = false;
      });

      AppUtils.successToast('Successfully created');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.colorGreen,
        title: const Text(
          'Create Product',
          style: TextStyle(
            color: AppStyles.colorWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: isLoading ? Center(
              child: CircularProgressIndicator(),
            ) : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      inputOnChange('ProductName', value);
                    },
                    decoration: AppStyles.inputDecoration('Product name'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      inputOnChange('ProductCode', value);
                    },
                    decoration: AppStyles.inputDecoration('Product code'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      inputOnChange('Img', value);
                    },
                    decoration: AppStyles.inputDecoration('Product image'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      inputOnChange('UnitPrice', value);
                    },
                    decoration: AppStyles.inputDecoration('Unit price'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      inputOnChange('TotalPrice', value);
                    },
                    decoration: AppStyles.inputDecoration('Total price'),
                  ),
                  const SizedBox(height: 20),
                  AppStyles.appDropDownStyle(
                    DropdownButton(
                      value: formData['Qty'],
                      isExpanded: true,
                      underline: Container(),
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 16,
                      ),
                      dropdownColor: Colors.white,
                      items: [
                        DropdownMenuItem(
                          value: '',
                          child: Text('Select Qt'),
                        ),
                        DropdownMenuItem(
                          value: '1 pcs',
                          child: Text('1 pcs'),
                        ),
                        DropdownMenuItem(
                          value: '2 pcs',
                          child: Text('2 pcs'),
                        ),
                        DropdownMenuItem(
                          value: '3 pcs',
                          child: Text('3 pcs'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != 'Select Qt') {
                          inputOnChange("Qty", value!);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        formOnSubmit();
                      },
                      style: AppStyles.appButtonStyle(),
                      child: const Text('Submit', style: TextStyle(
                        color: AppStyles.colorWhite,
                        fontWeight: FontWeight.w500,
                      ),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
