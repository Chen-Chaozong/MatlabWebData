function [ lhbtj ] = sina_lhbtj( type,ndays )
%% Description sina_lhbtj ��ȡ����������ͳ��
%% Inputs:
%  type   ������ͳ�����ͣ�'ggtj','yytj','jgzz'
%  ndays  ������,5 10 30 60
%% Outputs:
%  lhbtj    ������ͳ��
%% 
    switch nargin
        case 0 
            type = 'ggtj';            
            ndays = 5;
        case 1          
            ndays = 5;
    end
    if ~any(strcmp(type,{'ggtj','yytj','jgzz'}))
        error('type error, should in ggtj, yytj, jgzz');
    end
    if ~any(ndays == [5,10,30,60] | strcmp(ndays,{'5','10','30','60'}))
        error('ndays error, should in 5 10 30 60');
    end
    ndays = num2str(ndays);
    page= urlread(strcat('http://vip.stock.finance.sina.com.cn/q/go.php/vLHBData/kind/',type,'/index.phtml?last=',ndays,'&num=10000'),'Charset','GB2312');
    switch type
        case 'ggtj'
            exp = 'blank\D{2}(?<code>\d{6})[^"]*\D{1}[^>]*>(?<name>\S*)\D{2}a\D*d>(?<time>\S*)\D{2}t\D*d>(?<cumbuy>\S*)\D{2}t\D*d>(?<cumsell>\S*)\D{2}t\D*d>(?<netvalue>\S*)\D{2}t\D*d>(?<buynum>\S*)\D{2}t\D*d>(?<sellnum>\S*)\D{2}t';
        case 'yytj'
            exp = '[^>]*>(?<name>\S*)\D{2}a\D*d>(?<time>\S*)\D{2}t\D*d>(?<cumbuy>\S*)\D{2}t\D*d>(?<buynum>\S*)\D{2}t\D*d>(?<cumsell>\S*)\D{2}t\D*d>(?<sellnum>\S*)\D{2}t\D*d>(?<symbols>\S*)\D{2}t';
        case 'jgzz'
            exp = 'blank\D{2}(?<code>\d{6})[^"]*\D{1}[^>]*>(?<name>\S*)\D{2}a[^"]*\D{1}[^"]*\D{1}[^"]*\D{1}[^"]*\D{1}\D*d>(?<cumbuy>\S*)\D{2}t\D*d>(?<buytime>\S*)\D{2}t\D*d>(?<cumsell>\S*)\D{2}t\D*d>(?<selltime>\S*)\D{2}t\D*d>(?<netvalue>\S*)\D{2}t';
    end
    try
        lhbtj=struct2table(regexp(page,exp,'names'));
        switch type
            case 'ggtj'
                lhbtj.time = data.web.webstr2num(lhbtj.time);
                lhbtj.cumbuy = data.web.webstr2num(lhbtj.cumbuy);
                lhbtj.cumsell = data.web.webstr2num(lhbtj.cumsell);
                lhbtj.netvalue = data.web.webstr2num(lhbtj.netvalue);
                lhbtj.buynum = data.web.webstr2num(lhbtj.buynum);
                lhbtj.sellnum = data.web.webstr2num(lhbtj.sellnum);
            case 'yytj'
                lhbtj.time = data.web.webstr2num(lhbtj.time);  % �ϰ����
                lhbtj.cumbuy = data.web.webstr2num(lhbtj.cumbuy); % �ۼ������
                lhbtj.buynum = data.web.webstr2num(lhbtj.buynum);  % ����ϯλ��
                lhbtj.cumsell = data.web.webstr2num(lhbtj.cumsell);  % �ۼ�������
                lhbtj.sellnum = data.web.webstr2num(lhbtj.sellnum);  % ����ϯλ��
            case 'jgzz'
                lhbtj.cumbuy = data.web.webstr2num(lhbtj.cumbuy);  % �ۼ������
                lhbtj.buytime = data.web.webstr2num(lhbtj.buytime); % �������
                lhbtj.cumsell = data.web.webstr2num(lhbtj.cumsell);  % �ۼ�������
                lhbtj.selltime = data.web.webstr2num(lhbtj.selltime);  % ��������
                lhbtj.netvalue = data.web.webstr2num(lhbtj.netvalue);  % ����
        end
    catch
        disp('������');
    end    
    lhbtj.datetime = repmat(date,size(lhbtj(:,1)));
end

