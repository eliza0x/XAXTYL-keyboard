led = GPIO.new(25, GPIO::OUT) # デバッグ用LED
led.write(1) # 初期化開始時LED点灯

kbd = Keyboard.new

# splitと相性が悪い？うまく機能しないので無効化した
# この処理群はinit_pinsの設定以前に行う
# require "via"
# kbd.via = true
# kbd.via_layer_count = 3

# この処理群はinit_pinsの設定以前に行う
kbd.split = true
kbd.uart_pin = 17 # ひとつのpinでタイミングを切り替えて入力・出力をやってるらしい。どうやってタイミングを計っているんだろう。
kbd.set_anchor(:right) # USBを指す側のraspberry pi picoを右側に設定している

kbd.init_pins(
  [ 5, 6, 7, 8 ], # row
  [ 4, 3, 2, 1, 0 ] # col
)

kbd.add_layer :default, %i(
  KC_Q      KC_W          KC_E       KC_R    KC_T     KC_Y       KC_U       KC_I      KC_O     KC_P
  KC_A      KC_S          KC_D       KC_F    KC_G     KC_H       KC_J       KC_K      KC_L     KC_ENT
  KC_Z      KC_X          KC_C       KC_V    KC_B     KC_N       KC_M       KC_SCOLON KC_QUOTE KC_DEL
  KC_LALT   KC_LGUI       KC_ESC     KC_LSFT KC_LCTL  FUN_NUM    FUN_SYM    KC_SPACE  KC_TAB   KC_BSPC
)
kbd.add_layer :LAY_SYM, %i(
  KC_EXLM   KC_AT         KC_HASH    KC_DLR  KC_PERC  KC_CIRC    KC_LPRN    KC_RPRN  KC_AMPR  KC_ASTER
  KC_NO     KC_LCBR       KC_RCBR    KC_PLUS KC_UNDS  KC_MINUS   KC_EQUAL   KC_LBRC  KC_RBRC  KC_ENT
  KC_QUES   KC_LABK       KC_RABK    KC_PIPE KC_TILD  KC_GRAVE   KC_BSLS    KC_COMMA KC_DOT   KC_SLSH
  KC_LALT   KC_LGUI       KC_ESC     KC_LSFT KC_LCTL  FUN_NUM    FUN_SYM    KC_SPACE  KC_TAB   KC_BSPC
)
kbd.add_layer :LAY_NUM, %i(
  KC_1      KC_2          KC_3       KC_4    KC_5     KC_6       KC_7       KC_8      KC_9     KC_0
  KC_F11    KC_F12        KC_PSCREEN KC_HOME KC_END   KC_LEFT    KC_DOWN    KC_UP     KC_RIGHT KC_ENT
  KC_F1     KC_F2         KC_F3      KC_F4   KC_F5    KC_F6      KC_7       KC_8      KC_9     KC_10
  KC_LALT   KC_LGUI       KC_ESC     KC_LSFT KC_LCTL  FUN_NUM    FUN_SYM    KC_SPACE  KC_TAB   KC_BSPC
)

kbd.define_mode_key :FUN_SYM, [ :KC_NO, :LAY_SYM, 200, 200 ]
kbd.define_mode_key :FUN_NUM, [ :KC_NO, :LAY_NUM, 200, 200 ]

led.write(0) # 初期化終了時LED消灯

kbd.start!