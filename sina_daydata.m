function [ daydata ] = sina_daydata( code, isindex )
%% Description sina_daydata 获取新浪日线数据
%% Inputs:
%  code   证券代码
%  date   日期
%% Outputs:
%  daydata    日线数据
%% 
    switch nargin
        case 1
            url = strcat('http://vip.stock.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/',code,'.phtml');
        otherwise
            switch isindex
                case {1, 'y','Y','yes','YES'}
                    url = strcat('http://vip.stock.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/',code,'/type/S.phtml');
                otherwise
                    url = strcat('http://vip.stock.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/',code,'.phtml');
            end
    end
    page = webread(url);    
    yearexp ='\s*option value="(?<year>\d{4})';
    year =regexp(page,yearexp,'names');    
    year =struct2table(year);
    season = regexp(page,'option value="(?<season>\d{1})\D{2}selected','names');
    
    dataexp = '&date=(?<datetime>\d{4}\-\d{2}\-\d{2})\D*\d{4}\-\d{2}\-\d{2}\D*(?<open>\d*.\d*)\D*(?<high>\d*.\d*)\D*(?<close>\d*.\d*)\D*(?<low>\d*.\d*)\D*(?<volume>\d*)\D*(?<amount>\d*)';
    daydata =regexp(page,dataexp,'names'); 
    dataexp2 = 'center"\D*(?<datetime>\d{4}\-\d{2}\-\d{2})\D*(?<open>\d*.\d*)\D*(?<high>\d*.\d*)\D*(?<close>\d*.\d*)\D*(?<low>\d*.\d*)\D*(?<volume>\d*)\D*(?<amount>\d*)';
    
    for i = 1:size(year,1)
        for j = 1:4
            if i == 1
                k = str2num(season.season(1)) - j;
            else
                k = 5 - j;
            end
            if k < 1
                break;
            end
            urltmp = char(strcat(url,'?year=',year.year(i),'&jidu=',num2str(k)));
            pagetmp = webread(urltmp);
            tmpdata = regexp(pagetmp,dataexp,'names');
            if any(size(tmpdata)==0)
                tmpdata = regexp(pagetmp,dataexp2,'names');
            end
            daydata =[daydata tmpdata]; 
        end
        display(['进度：',num2str(i),'/',num2str(size(year,1))]);
    end
    daydata =struct2table(daydata);    
    daydata.datetime = cellfun(@datenum, daydata.datetime);
    daydata.open = cellfun(@str2num, daydata.open);
    daydata.high = cellfun(@str2num, daydata.high);
    daydata.low = cellfun(@str2num, daydata.low);
    daydata.close = cellfun(@str2num, daydata.close);
    daydata.volume = cellfun(@str2num, daydata.volume);
    daydata.amount = cellfun(@str2num, daydata.amount);
    daydata = [table(datestr(daydata.datetime),'VariableNames',{'datetimestr'}) daydata];
    daydata=sortrows(daydata,'datetime');
end

