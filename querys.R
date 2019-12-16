###############################################################################
# OPCIONALES
# JAVIER MARTINEZ
###############################################################################

#despacho
.despacho <- function(empresa){
    
    sprintf(  "SELECT   	   
          	   D.[NroViaje]
          	  ,V.[Patente]
          	  --,V.[RutConductor]
          	  --,V.[Conductor]
          	  --,D.[NroDespacho]
              --,D.[Secuencia]
              --,D.[IdEstado]
              ,D.[FechaEstimadaEntrega]
              ,D.[OrigenCodigo]
              ,D.[DestinoCodigo]
              --,D.[FHLLegadaOrigen]
              --,D.[FHSalidaOrigen]
              --,D.[FHLLegadaDestino]
              --,D.[FHSalidaDestino]
              --,D.[FHCercania]
              --,D.[EstadoLat]
              --,D.[EstadoLon]
              ,D.[FechaCreacion]
              --,D.[UsuarioCreacion]
              ,D.[FechaModificacion]
              ,D.[UsuarioModificacion]
        	  --,D.[CodigoEPV]
          FROM [%s].[dbo].[Track_Despacho] AS D
          INNER JOIN [%s].[dbo].[Track_Viaje] AS V
          ON D.NroViaje = V.NroViaje
          WHERE D.[FechaCreacion] >= getdate()"
              ,empresa
              ,empresa)
    
    
            }
