CentroFormacion    1:N Dependencia

Dependencia        1:N Usuario

Usuario            1:N Actividad

Usuario            1:N DiarioGestion

Usuario            1:N Auditoria

Actividad          1:N Evidencia

Actividad          N:M Proyecto

Actividad          N:M CompromisoDesempeno

Actividad          N:M ObligacionContractual

Actividad          N:M Etiqueta

Usuario            N:M Usuario
                  (EstructuraJerarquica)
