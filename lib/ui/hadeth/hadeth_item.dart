import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamy_app/model/hadeth_model.dart';
import 'package:islamy_app/utils/app_assets.dart';
import 'package:islamy_app/utils/app_colors.dart';

class HadethItem extends StatefulWidget {
  int index;
  HadethItem({required this.index});

  @override
  State<HadethItem> createState() => _HadethItemState();
}

class _HadethItemState extends State<HadethItem> {
  Hadeth? hadeth;
  @override
  void initState() {
    super.initState();
    loadHadethFile(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.02),
      decoration: BoxDecoration(
          color: AppColor.elevatedBg,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage(
            AppAssets.hadithCardBackGround,
            
          ))),
      child: hadeth == null
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColor.blakeIconElevatedBg,
              ),
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      AppAssets.leftIconSoura,
                      width: width * 0.16,
                      color: AppColor.blakeIconElevatedBg,
                    ),
                    Expanded(
                      child: Text(
                        hadeth?.title ?? '',
                        // style: AppStyles.bold20Black,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Image.asset(
                      AppAssets.righticonSoura,
                      width: width * 0.16,
                      color: AppColor.blakeIconElevatedBg,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Expanded(
                    child: SingleChildScrollView(
                        child: Text(
                  hadeth?.content ?? '',
                  textAlign: TextAlign.center,
                  //style: AppStyles.bold16Black
                ))),
                Image.asset(
                  AppAssets.botuniconSoura,
                  color: AppColor.blakeIconElevatedBg,
                  fit: BoxFit.fill,
                )
              ],
            ),
    );
  }

  Future<void> loadHadethFile(int index) async {
    String fileContent =
        await rootBundle.loadString('assets/Hadeeth/h$index.txt');
    int fileLinesIndex = fileContent.indexOf('\n');
    String title = fileContent.substring(0, fileLinesIndex);
    String content = fileContent.substring(fileLinesIndex + 1);
    hadeth = Hadeth(title: title, content: content);
    setState(() {});
  }
}
