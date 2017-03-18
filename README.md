# MatlabWebData
Get Web Data Using Matlab
  
 包括历史数据、财务数据等，主要函数如下：
      
      获取新浪日线数据：   [ daydata ] = sina_daydata( code, isindex )
      
      获取新浪tick数据：   [ tickdata ] = sina_tickdata( code,datetime )
      
      获取凤凰财经历史数据：[ histdata ] = ifeng_histdata( code,ktype)
      
      获取新浪财务分析数据：[ cwfx ] = sina_cwfx( type,datayear,dataquarter )
      
      获取新浪大宗交易数据：[ dzjy ] = sina_dzjy(datanum, pagenum )
      
      获取新浪行业关注度:   [ hygzd ] = sina_hygzd( ndays )
      
      获取新浪机构重仓数据: [ jgzc ] = sina_jgzc( type,datayear,dataquarter )
      
      获取新浪龙虎榜日数据：[ lhb ] = sina_lhb( tradedate )
      
      获取新浪龙虎榜统计：  [ lhbtj ] = sina_lhbtj( type,ndays 
      
      获取新浪历史分红数据：[ lsfh ] = sina_lsfh(datanum,pagenum)
      
      获取新浪公司内部交易数据：[ nbjy ] = sina_nbjy(datanum, pagenum )
      
      获取新浪融资融券数据： [ trzrq, drzrq ] = sina_rzrq( tradedate )
      
      获取新浪限售股解禁：   [ xsjj ] = sina_xsjj( startdate, enddate )
    
    
    
