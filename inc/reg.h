%ifndef REG_H
%define REG_H 1

%define REGISTER_ES	[SS:BP + 2]
%define REGISTER_DS	[SS:BP + 4]
%define REGISTER_SS	[SS:BP + 6]
%define REGISTER_DI	[SS:BP + 2 + 6]
%define REGISTER_SI	[SS:BP + 4 + 6]
%define REGISTER_BP	[SS:BP + 6 + 6]
%define REGISTER_SP	[SS:BP + 8 + 6]
%define REGISTER_BX	[SS:BP + 10 + 6]
%define REGISTER_DX	[SS:BP + 12 + 6]
%define REGISTER_CX	[SS:BP + 14 + 6]
%define REGISTER_AX	[SS:BP + 16 + 6]
%define REGISTER_IP	[SS:BP + 18 + 6]
%define REGISTER_CS	[SS:BP + 20 + 6]

%endif
