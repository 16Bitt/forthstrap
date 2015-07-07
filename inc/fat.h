
;BPB attributes
define ENTRY_JMP		(0x7C00 + 0)
define OEM_IDENT		(0x7C00 + 3)
define BYTES_PER_SECTOR	(0x7C00 + 11)
define SECTORS_PER_CLUSTER	(0x7C00 + 13)
define NUM_RESERVED		(0x7C00 + 14)
define NUM_FATS		(0x7C00 + 16)
define NUM_ENTRIES		(0x7C00 + 17)
define NUM_SECTORS		(0x7C00 + 19)
define MEDIA_DESCRIPTOR	(0x7C00 + 21)
define SECTORS_PER_FAT		(0x7C00 + 22)
define SECTORS_PER_TRACK	(0x7C00 + 24)
define NUM_HEADS		(0x7C00 + 26)
define NUM_HIDDEN		(0x7C00 + 28)
define NUM_SECTORS_HUGE	(0x7C00 + 32)

;Extended BPB attributes
define DRIVE_NUM		(0x7C00 + 36)
define NT_FLAGS		(0x7C00 + 37)
define SIGNATURE		(0x7C00 + 38)
define SERIAL_NUM		(0x7C00 + 39)
define VOLUME_LABEL		(0x7C00 + 43)
define FS_IDENT		(0x7C00 + 54)

;Directory entries
define FILENAME	0
define ATTRIBUTES	11
define DIR_NT_RESERVED	12
define CR_TENTHS	13
define CR_TIME		14
define CR_DATE		16
define AC_DATE		18
define CLUSTER_HIGH	20
define MOD_TIME	22
define MOD_DATE	24
define CLUSTER_LOW	26
define BYTE_SIZE	28
define DIR_SIZE	32

define EXTENDED_DIR	0x0F

