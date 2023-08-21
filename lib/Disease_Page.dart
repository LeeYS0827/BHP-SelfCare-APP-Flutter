import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DiseasePage extends StatelessWidget {
  const DiseasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xFFEC407A)),
      home: Scaffold(
        backgroundColor: Colors.pink[400],  // 添加這一行
        appBar: AppBar(title: const Text('攝護腺肥大 疾病介紹')),
        body: ListView(
          children: <Widget>[
            // Spacer(),  // 空白
            titleSection,
            const ElevatedCard(
              titleText: '致病原因',
              contentText:
                  "造成攝護腺肥大之原因，最主要是隨著年齡的增長，男性荷爾蒙的刺激造成組織的增生；其他包含生活習慣如抽煙、喝酒，肥胖，是否有其他內科疾病如肝硬化、高血壓，甚至是種族、社會經濟地位都有影響。\n\n隨著組織增生造成攝護腺肥大會進一步引起排尿障礙。初、中期常見的症狀有頻尿、排尿慢、尿流細小、急迫性尿失禁、有餘尿感、膀胱發炎、夜尿次數增多；到晚期時則可能有膀胱發炎、血尿、尿滯留、因為尿滯留造成的腎功能障礙，甚至是尿毒症。",
              rowText: "主因: 年齡增長，男性荷爾蒙的刺激造成組織的增生",
              linkText: '參考連結: 中山醫學大學附設醫院',
              // 新增的連結文字
              linkUrl: "http://web.csh.org.tw/web/222010/?p=3061", // 新增的連結網址
            ),
            const ElevatedCard(
              titleText: '危險因子',
              contentText:
                  '良性攝護腺肥大是中老年男性的公敵，根據研究，五十歲以上的男性開始會有這種困擾，八十歲以上的發生率更高達九成以上。良性攝護腺肥大的發生，除了與人種、遺傳、年齡、體內荷爾蒙等因素有關外，其他致病的危險因子，還包括肥胖、運動量太少、體內氧化作用增強及自由基作用、體內血糖和胰島素濃度增加、體內膽固醇濃度過高等。',
              rowText: "高風險: 肥胖、運動量太少、三高族群",
              linkText: "參考連結: 台灣尿失禁防治協會",
              // 新增的連結文字
              linkUrl: "http://www.tcs.org.tw/forum/article_info.asp?/70.html",
            ),
            const ElevatedCard(
              titleText: '症狀',
              contentText:
                  '攝護腺肥大也稱為前列腺肥大，主要是攝護腺出現異常增生，並壓迫到尿道、膀胱等，出現各種泌尿道症狀，包括排尿中斷、尿速慢、頻尿或是尿失禁。5成的50歲以上男性會開始出現攝護腺肥大的問題，隨著年紀越大會越困擾。攝護腺肥大與攝護腺癌並沒有明顯的相關，得到此病不用太過焦慮。',
              rowText: "什麼是攝護腺肥大？",
              linkText: "參考連結: 康健知識庫", // 新增的連結文字
              linkUrl: "https://kb.commonhealth.com.tw/library/271.html#data-3-collapse",
            ),
            const ElevatedCard(
              titleText: '藥物治療',
              contentText:
                  "一、甲型腎上腺素受體阻斷劑：此類藥品可以使膀胱出口及尿道平滑肌放鬆，減低膀胱出口阻塞，緩和尿道的壓迫，改善排尿困難的情形，服藥短期就可以感受到明顯的症狀改善，但對於縮小攝護腺的體積並無幫助。\n\n"
                  "二、5α還原酶抑制劑：此類藥品的作用則是抑制攝護腺細胞內的5α還原酶阻斷二氫睪固酮，使肥大的攝護腺體積縮小。相較於甲型腎上腺素受體阻斷劑，5α還原酶抑制劑在改善下泌尿道症狀的效果較緩慢且較不顯著。\n\n"
                  "三、抗膽鹼藥物（Anticholinergics）：可以增加膀胱容量，增加膀胱首度收縮感時的尿量，進而減少患者頻尿次數，改善生活品質。\n\n"
                  "四、其他藥物：尿滯留(Bethanechol)、夜尿(Imipramine、Desmopressin)、治療伴有急尿、頻尿和/或急迫性尿失禁症狀的膀胱過動症(Mirabegron)。\n\n"
                  "五、第五型磷酸二酯酶抑制劑（phosphodiesterase type 5 inhibitor），也稱為PDE5抑制劑：PDE-5豐富分佈於陰莖海綿體，也小量表現在全身和肺部血管上，而抑制PDE-5可進而鬆弛平滑肌、增加血流量。此類藥物原本主要用於治療勃起功能障礙，但近年發現Tadalafil也可以改善攝護腺肥大所引起的排尿障礙相關症狀。",
              rowText: "醫訊介紹",
              linkText: "參考連結: 東元綜合醫院", // 新增的連結文字
              linkUrl: "https://www.tyh.com.tw/b_health_s.php?new_id=2275",
            ),
            const ElevatedCard(
              titleText: '非藥物治療',
              contentText:
                  "並非所有攝護腺肥大患者均需要手術，約有一半患者只需簡單藥物控制，症狀即可改善，但若有以下症狀患者就需接受手術治療：反覆性尿路感染，經常性血尿，反覆性尿滯留，腎水腫及腎功能受損，小便症狀嚴重，藥物治療無效，或有併發症產生，攝護腺括除術早已是一常規手術，沒有傷口，一般只需住院3-4天，甚少有併發症產生。行政院長蕭萬長就是接受此手術。\n\n攝護腺肥大雖然並非都需要手術治療，但不需要手術治療的病患仍須定期至泌尿科門診追蹤，因有少數病患可能併有攝護腺癌，且攝護腺癌目前已是台灣地區男性最常見的，年齡滿50歲的男性不得不小心。",
              rowText: "醫訊介紹",
              linkText: "參考連結: 高雄榮民總醫院",
              // 新增的連結文字
              linkUrl:
                  "https://org.vghks.gov.tw/gu/News_Content.aspx?n=443D52499B00880B&sms=75CDA1900F405FB4&s=871782919DF02740",
            ),
            // const FilledCardExample(),
            // OutlinedCardExample(),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}

// 靜態寫法: 點選後，背景顏色不變: class ElevatedCard extends StatelessWidget {}
// class ElevatedCard extends StatelessWidget {
//   final String titleText;
//   final String contentText;
//   final String rowText;
//   final String? linkText;
//   final String? linkUrl;
//
//   const ElevatedCard({
//     Key? key,
//     required this.titleText,
//     required this.contentText,
//     required this.rowText,
//     this.linkText,
//     this.linkUrl,
//   }) : super(key: key);
//
//   @override
//   // Flutter 中常見的 build 方法，它返回一個 Widget
//   // BuildContext 是一個對當前 widget tree 的參照，允許您從 tree 中提取其他 widget 的資訊
//   Widget build(BuildContext context) {
//     return Center(
//       // 其子項目置中的 widget
//       child: Card(
//         clipBehavior: Clip.hardEdge,
//         child: ExpansionTile(
//           title: Text(titleText),
//           children: <Widget>[
//             SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,  // 子項目之間均勻地分配可用的空間
//                     mainAxisAlignment: MainAxisAlignment.start, // 使子項目靠左對齊
//                     children: <Widget>[
//                       const Icon(Icons.star, color: Colors.pinkAccent),
//                       Text(rowText,
//                           style: const TextStyle(color: Colors.pinkAccent)),
//                       // Icon(Icons.star, color: Colors.blue,),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(contentText),
//                   ),
//                   if (linkText != null && linkUrl != null)
//                     InkWell(
//                       onTap: () async {
//                         if (await canLaunchUrl(Uri.parse(linkUrl!))) {
//                           await launchUrl(Uri.parse(linkUrl!));
//                         } else {
//                           throw 'Could not launch $linkUrl';
//                         }
//                       },
//                       child: Text(
//                         linkText!,
//                         style: TextStyle(
//                           color: Colors.blue,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                   // You can add more widgets here to make the content longer and test the scrolling.
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// 動態寫法
class ElevatedCard extends StatefulWidget {  // 點選後，背景顏色會改變
  final String titleText;
  final String contentText;
  final String rowText;
  final String linkText;
  final String linkUrl;

  const ElevatedCard({
    Key? key,
    required this.titleText,
    required this.contentText,
    required this.rowText,
    required this.linkText,
    required this.linkUrl,
  }) : super(key: key);

  @override
  ElevatedCardState createState() => ElevatedCardState();
}

class ElevatedCardState extends State<ElevatedCard> {
  bool isExpanded = false; // This will track if the card is expanded or not

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: isExpanded ? Colors.lightBlueAccent : Colors.white, // Set the background color based on isExpanded value
      child: ExpansionTile(
        title: Text(widget.titleText,
          style: const TextStyle(
            // color: Colors.white,
            fontWeight: FontWeight.bold,
          )
        ),
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: Colors.yellowAccent),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.rowText,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
              ),// This will make the text bold)),
            ],
          ),
          const SizedBox(height: 12.0),  // This will create an empty space of 16 pixels height.
          Text(widget.contentText),
          TextButton(
            onPressed: () async {
              if (await canLaunchUrl(Uri.parse(widget.linkUrl))) {
                await launchUrl(Uri.parse(widget.linkUrl));
              } else {
                throw 'Could not launch ${widget.linkUrl}';
              }
            },
            child: Text(
              widget.linkText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
      ),
    );
  }
}




Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: const Text(
                '良性前列腺增生症（Benign Prostatic Hyperplasia，BPH）',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Text(
              "俗稱前列腺肥大症或攝護腺肥大，以前列腺中葉增生為實質改變而引起的一組症候群，良性前列腺增生症是屬於男性常見的疾病。",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      /*3*/
      const Icon(
        Icons.accessibility,
        color: Colors.lightBlueAccent,
        size: 50.0,
      ),
      // const Text('- Wikipedia'),
    ],
  ),
);

class FilledCardExample extends StatelessWidget {
  const FilledCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: const SizedBox(
          width: 300,
          height: 100,
          child: Center(child: Text('Filled Card')),
        ),
      ),
    );
  }
}

class OutlinedCardExample extends StatelessWidget {
  const OutlinedCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: const SizedBox(
          width: 300,
          height: 100,
          child: Center(child: Text('Outlined Card')),
        ),
      ),
    );
  }
}
