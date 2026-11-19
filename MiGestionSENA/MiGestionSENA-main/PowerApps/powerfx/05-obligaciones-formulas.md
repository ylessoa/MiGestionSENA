Power Fx - Obligaciones
Filter( mgs_obligacioncontractual, Contratista.Email = User().Email )

CountRows( Filter( mgs_obligacioncontractual, mgs_avance < 100 ) )
