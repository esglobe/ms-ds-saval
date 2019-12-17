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
            --,D.[FechaModificacion]
            --,D.[UsuarioModificacion]
        	  --,D.[CodigoEPV]
          FROM [%s].[dbo].[Track_Despacho] AS D
          INNER JOIN [%s].[dbo].[Track_Viaje] AS V
          ON D.NroViaje = V.NroViaje
          WHERE D.[FechaCreacion] >= '%s'"
              ,empresa
              ,empresa
              , Sys.Date()
          )
    

  
            }


#########
#last
.last_positios <- function(compania){
  
  
  
  sprintf(  "Select
   --(case when viajes.FechaTermino  < GETDATE() or (viajes.FechaTermino IS null and Viajes.FechaInicio IS null)  or (Viajes.FechaTermino < Viajes.FechaInicio) then null else Viajes.NroViaje end) AS NroViaje
    Viajes.NroViaje
    ,Viajes.IdEstado
   ,Viajes.FechaInicio
   ,viajes.FechaTermino 
   ,lp.Patente        AS plate
   ,Lp.Latitud        AS lat
   ,Lp.Longitud       AS lng
   ,Viajes.Nombre     AS origin_name
   --,0                 AS order_id
   ,lp.Fecha          AS date
   ,lp.FechaInsercion AS FechaInsercion
   ,lp.Proveedor      AS Proveedor
   --,lp.NombreMovil    AS nombreMovil
   --,Viajes.CodPatente AS cod_plate
   ,(case when viajes.FechaTermino < GETDATE()  or (viajes.FechaTermino IS null and Viajes.FechaInicio IS null ) or (Viajes.FechaTermino < Viajes.FechaInicio) then null else Datediff( Second,Viajes.FechaInicio, GETDATE() ) / 60.0 end) AS time_trip
   --,0                 AS total_dispatches
   --,0                 AS pending_dispatches
   --,Alertas           AS alert_id
   ,Alertas
   --,NULL              AS label
   ,'%s'    AS compania
   ,Viajes.Transportista as Transportista
   ,lp.Puerta1
   ,lp.Temperatura1
   ,lp.Temperatura2
   from [%s].dbo.Track_LastPositions lp
   Outer Apply
   (
       Select top 1
       tv.*
       ,M.Transportista
       ,cd.Nombre
            , convert(varchar(8),lp.fecha,112) FHRep
            , convert(varchar(8),tv.FechaViaje,112) FHViaje
       from [%s].dbo.Track_Viaje Tv WITH (NOLOCK)
       Left Join
       [%s].dbo.CentroDistribucion Cd WITH (NOLOCK)
       on Tv.CodCd = cd.codigointerno
       left join [%s].dbo.Track_Movil M with(nolock)
        on M.Patente = tv.Patente
       where
       lp.patente = tv.patente
        and Tv.FechaViaje >= '%s'              
       and convert(varchar(8),lp.fecha,112) >= convert(varchar(8),tv.FechaViaje,112)
       order by tv.FechaInicio desc
   ) AS Viajes
   Outer apply
   (Select TipoAlerta Alertas--Count(1) Alertas
    from [%s].dbo.Alerta A WITH (NOLOCK)
    where  A.NroTransporte = Viajes.NroViaje
    and A.Permiso = 'NO AUTORIZADA') Alertas
    Where lp.latitud <> 0
    and lp.longitud <> 0
    and lp.Fecha >= '%s'
    and Viajes.NroViaje is not null"
            , compania, compania, compania, compania
            , compania, Sys.Date(), compania, Sys.Date() )
  
    
  }





