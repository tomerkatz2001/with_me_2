import 'dart:convert';

import 'package:with_me/header.dart';


class AvatarShop {
  AvatarShop(String s) : acquired_items=[] {
    fromString(s);
  }

  List<List<List<bool>>> acquired_items;
  static List<String> groups =
  [
    'images/face.png',
    'images/color.png',
    'images/hanger.png'
    // 'images/heart.png'

  ];

  static List<List<String>> sub_groups =
  [
    [
      'images/eyes.png',
      'images/brows.png',
      'images/mouth.png',
    ],
    [
      'images/body.png',
      'images/eyes.png',
      'images/mouth.png',
    ],
    [
      'images/pantssign.png',
      'images/skirtsign.png'
    ],
    // [
    //   'images/paint.png',
    //   'images/tennis.png',
    //   'images/headphones.png',
    // ]
  ];
  static List<List<List<Tuple2<String, int>>>> merch =
  [
    [ //face
      [ //eyes
        Tuple2('images/glasses1.png', 0),
        Tuple2('images/glasses2.png', 0),
        Tuple2('images/glasses3.png', 10),
        Tuple2('images/glasses4.png', 12),
      ],
      [], //brows
      [], //lips
    ],
    [ //color
      [ //body
        Tuple2('images/color(ff6f6ca7).png', 0),
        Tuple2('images/color(ffa6d6c3).png', 0),
        Tuple2('images/color(ffdabfa0).png', 0),
        Tuple2('images/color(ffefb3e2).png', 0),
      ],
      [ //eyes
        Tuple2('images/color(ff6f6ca7).png', 0),
        Tuple2('images/color(ffa6d6c3).png', 0),
        Tuple2('images/color(ffdabfa0).png', 0),
        Tuple2('images/color(ffefb3e2).png', 0),
      ],
      [ //lips
        Tuple2('images/color(ff6f6ca7).png', 0),
        Tuple2('images/color(ffa6d6c3).png', 0),
        Tuple2('images/color(ffdabfa0).png', 0),
        Tuple2('images/color(ffefb3e2).png', 0),
      ]
    ],
    [//clothes
      [//pants
        Tuple2('images/armypants.png', 0),
        Tuple2('images/bluepants.png', 0),
        Tuple2('images/pinkpants.png', 0),
      ],
      [
        Tuple2('images/skirt.png', 2),
        Tuple2('images/skirt2.png', 3),
      ]
    ],
    // [
    //   [
    //     Tuple2('images/hobbies/angel.png', 0),
    //     Tuple2('images/hobbies/StayInSchoolKids.png', 0),
    //     Tuple2('images/hobbies/me.png', 0),
    //     Tuple2('images/hobbies/Painter.png', 0),
    //
    //   ],
    //   [],
    //   [],
    // ],

  ];

  static AvatarShop empty() {
    List<List<List<bool>>> ret = [];
    for (int i = 0; i < groups.length; i++) {
      ret.add([]);
      for (int j = 0; j < sub_groups[i].length; j++) {
        ret[i].add([]);
        for (int n = 0; n < merch[i][j].length; n++) {
          ret[i][j].add((merch[i][j][n].item2==0)? true : false);
        }
      }
    }
    var a = AvatarShop(ret.toString());
    a.acquired_items=ret;
    return a;
  }

  @override
  toString() {
    var ret = [];
    for (int i = 0; i < groups.length; i++) {
      ret.add([]);
      for (int j = 0; j < sub_groups[i].length; j++) {
        ret[i].add([]);
        for (int n = 0; n < merch[i][j].length; n++) {
          ret[i][j].add(acquired_items[i][j][n] ? 1 : 0);
        }
      }
    }
    return ret.toString();
  }

  fromString(String s) {
    print(s);
    var lists = json.decode(s);
    print(lists);
    print('e');
    if (lists.length != merch.length) {
      acquired_items = AvatarShop
          .empty()
          .acquired_items;
      return;
    }
    for (int i = 0; i < groups.length; i++) {
      if (lists[i].length != merch[i].length) {
        acquired_items = AvatarShop
            .empty()
            .acquired_items;
        return;
      }
      for (int j = 0; j < sub_groups[i].length; j++) {
        if (lists[i][j].length != merch[i][j].length) {
          acquired_items = AvatarShop
              .empty()
              .acquired_items;
          return;
        }
      }
    }

    acquired_items = [];
    for (int i = 0; i < groups.length; i++) {
      acquired_items.add([]);
      for (int j = 0; j < sub_groups[i].length; j++) {
        acquired_items[i].add([]);
        for (int n = 0; n < merch[i][j].length; n++) {
          acquired_items[i][j].add((lists[i][j][n] == 1) ? true : false);
        }
      }
    }
  }


}

class AvatarData {
  static AvatarData? currAvatar;


  AvatarData(
      {this.body,
        this.glasses,
        this.hands,
        this.body_color,
        this.money,
        this.acquired,
        this.eye_color,
        this.pants,
        this.hobby
      }) {
    legs = legs ?? 'images/legs.png';
    body = body ?? AvatarData.body_default;
    hands = hands ?? AvatarData.hand_default;
    glasses = glasses ?? "images/glasses1.png";
    acquired = acquired ?? AvatarShop.empty();
    body_color = body_color ?? color_default;
    eye_color = eye_color ?? Colors.black;
  }
  Color? eye_color;

  AvatarShop? acquired;
  String? body;

  String? hobby;
  String? glasses;
  String? hands;
  String? pants;
  String? legs;
  int? money;
  Color? body_color;


  static Color color_default = Color(0xffdabfa0);

  static String body_default = "images/poo.png";
  static String hand_default = "images/handsopen.png";

  AvatarData clone(){
    return AvatarData(
        body: this.body,
        glasses: this.glasses,
        hands: this.hands,
        body_color: this.body_color,
        money: this.money,
        acquired: this.acquired,
        eye_color: this.eye_color,
        hobby: this.hobby
    );
  }

}