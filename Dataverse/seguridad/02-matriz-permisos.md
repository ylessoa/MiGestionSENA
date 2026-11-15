Matriz de Permisos Dataverse - Mi Gestión SENA
Convenciones
Símbolo	Significado
C	Create
R	Read
U	Update
D	Delete
A	Append
AT	Append To
________________________________________
Nivel de acceso
Código	Alcance
U	User
BU	Business Unit
PCBU	Parent Child Business Unit
ORG	Organization
________________________________________
mgs_usuario
Rol	C	R	U	D
Administrador	ORG	ORG	ORG	ORG
OrdenadorGasto	-	ORG	-	-
Coordinador	-	BU	-	-
Supervisor	-	BU	-	-
Funcionario	-	U	U	-
Contratista	-	U	U	-
________________________________________
mgs_dependencia
Rol	C	R	U	D
Administrador	ORG	ORG	ORG	ORG
OrdenadorGasto	-	ORG	-	-
Coordinador	-	BU	-	-
Supervisor	-	BU	-	-
Funcionario	-	U	-	-
Contratista	-	U	-	-
________________________________________
mgs_centroformacion
Rol	C	R	U	D
Administrador	ORG	ORG	ORG	ORG
OrdenadorGasto	-	ORG	-	-
Coordinador	-	ORG	-	-
Supervisor	-	ORG	-	-
Funcionario	-	ORG	-	-
Contratista	-	ORG	-	-
________________________________________
mgs_actividad
Rol	C	R	U	D
Administrador	ORG	ORG	ORG	ORG
OrdenadorGasto	-	ORG	-	-
Coordinador	-	PCBU	-	-
Supervisor	-	PCBU	-	-
Funcionario	U	U	U	U
Contratista	U	U	U	U
________________________________________
mgs_evidencia
Rol	C	R	U	D
Administrador	ORG	ORG	ORG	ORG
OrdenadorGasto	-	ORG	-	-
Coordinador	-	PCBU	-	-
Supervisor	-	PCBU	-	-
Funcionario	U	U	U	U
Contratista	U	U	U	U
________________________________________
mgs_proyecto
Rol	C	R	U	D
Administrador	ORG	ORG	ORG	ORG
OrdenadorGasto	-	ORG	-	-
Coordinador	BU	BU	BU	-
Supervisor	-	BU	-	-
Funcionario	U	U	U	-
Contratista	-	U	-	-
________________________________________
mgs_compromisodesempeno
Rol	C	R	U	D
Administrador	ORG	ORG	ORG	ORG
OrdenadorGasto	-	ORG	-	-
Coordinador	-	BU	-	-
Supervisor	-	-	-	-
Funcionario	U	U	U	-
Contratista	-	-	-	-
________________________________________
mgs_obligacioncontractual
Rol	C	R	U	D
Administrador	ORG	ORG	ORG	ORG
OrdenadorGasto	-	ORG	-	-
Coordinador	-	-	-	-
Supervisor	BU	BU	BU	-
Funcionario	-	-	-	-
Contratista	U	U	U	-
________________________________________
mgs_diariogestion
Rol	C	R	U	D
Administrador	ORG	ORG	-	-
OrdenadorGasto	-	-	-	-
Coordinador	-	-	-	-
Supervisor	-	-	-	-
Funcionario	U	U	U	U
Contratista	U	U	U	U
________________________________________
mgs_auditoria
Rol	C	R	U	D
Administrador	ORG	ORG	ORG	ORG
OrdenadorGasto	-	ORG	-	-
Coordinador	-	BU	-	-
Supervisor	-	BU	-	-
Funcionario	-	U	-	-
Contratista	-	U	-	-
________________________________________
mgs_estructurajerarquica
Rol	C	R	U	D
Administrador	ORG	ORG	ORG	ORG
OrdenadorGasto	-	ORG	-	-
Coordinador	-	BU	-	-
Supervisor	-	BU	-	-
Funcionario	-	-	-	-
Contratista	-	-	-	-

