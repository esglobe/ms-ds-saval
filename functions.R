###############################################################################
# OPCIONALES
# JAVIER MARTINEZ
###############################################################################



#######
# servidor a buscar 
#######
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
