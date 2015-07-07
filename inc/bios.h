
define BOOT_ENTRY	0x7C00
define BOOT_SIGNATURE	0xAA55

;These are the various services that the bios so lovingly gives us
define TEXT_SERVICE	0x10
define DISK_SERVICE	0x13
define KEYB_SERVICE	0x16
define CTRL_BREAK	0x1B

;TEXT SERVICES
define PUTCHAR		0x0E
define SETMODE		0x00
define SETSHAPE	0x01
define SETCURSOR	0x02
define GETCURSOR	0x03
define SCROLLUP	0x06
define SCROLLDOWN	0x07

;DISK SERVICES
define READSECTOR_B	0x02
define WRITESECTOR_B	0x03

;KEYB SERVICES
define READKEY_B	0x00
define GETKEY_B	0x01

