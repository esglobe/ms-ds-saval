###############################################################################
# CONEXIONES SERVIDOR
# JAVIER MARTINEZ
###############################################################################


#######
# CONEXIONES
#######

#open constructor
AltoConexion <- function(empresa = "TRANSPORTE_SAVAL"){
    
    #lista de servidores
    .server_select <- function(compania){
        
        lista <- list(
            TRANSPORTE_AASA  = "altotrack-sql2.clhc4wjn055a.us-east-1.rds.amazonaws.com"
            ,TRANSPORTE_FALABELLA   = "altotrack-sql2.clhc4wjn055a.us-east-1.rds.amazonaws.com"
            ,TRANSPORTE_SAAM  = "altotrack-sql2.clhc4wjn055a.us-east-1.rds.amazonaws.com"
            ,TRANSPORTE_SAVAL  = "altotrack-sql2.clhc4wjn055a.us-east-1.rds.amazonaws.com"
            ,TRANSPORTE_SITRANS  = "altotrack-sql2.clhc4wjn055a.us-east-1.rds.amazonaws.com"
            
            ,TRANSPORTE_CAROZZI  = "altotrack-sql.clhc4wjn055a.us-east-1.rds.amazonaws.com"
            ,TRANSPORTE_CCU  = "altotrack-sql.clhc4wjn055a.us-east-1.rds.amazonaws.com"
            ,TRANSPORTE_ACARREO  = "altotrack-sql.clhc4wjn055a.us-east-1.rds.amazonaws.com"
            ,TRANSPORTE_CORREOS  = "altotrack-sql.clhc4wjn055a.us-east-1.rds.amazonaws.com"
        )
        
        return( lista[[compania]] )
    }
    
    #conexion
    produ <- odbc::dbConnect(odbc::odbc()
                               ,Driver = "ODBC Driver 17 for SQL Server"
                               ,Server = .server_select(empresa)
                               ,UID = "bimicro"
                               ,PWD = "9XycA1n7"
                               ,Port = 1433
                               ,encoding = "latin1")
    
    
    
        
    lista <- list( 'conexion' = produ
                   ,'compania' =  empresa )
        
    class(lista) <- 'AltoConexion'
    
    
    return(lista)
    
}

#despacho
despacho <- function(empresa = "TRANSPORTE_SAVAL"){
    
    #querys
    source('querys.R')
    
    #conexion
    con <- AltoConexion(empresa)
    
    data <- odbc::dbSendQuery( con$conexion, .despacho(empresa)  ) 
    datos <- odbc::dbFetch(data)
    
    odbc::dbClearResult(data)
    odbc::dbDisconnect(con$conexion)
    
    
    return(datos)
    
    
    
}














