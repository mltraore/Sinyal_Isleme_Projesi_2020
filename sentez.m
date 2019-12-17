
parse  = parseMusicXML('nota.musicxml');                                    %Müzik parse edilir
zarf   = input('Zarf turunu seciniz : 1->ADSR  2->exponential  : ');    
hmk    = input('Harmonik sayisini giriniz : ');
fs     = 44100;                                                             %Örnekleme frekansı 44100 Hz
signal = [];                                                                 
revSig = [];                                                                 
time   = [];
tt     = [];


for i  = 223:229 %length(parse)
 frek  = note(parse(i,4));                                                  %Pitch'ten frekans döndürülür
 start = parse(i,6);
 dur   = parse(i,7);
 tt    = start:1/fs:(start+dur-1/fs);                                       %İlgili notanın zaman vektörü
 nota  = zeros(size(tt));
 
 for n = 1:hmk                                                              
         nota = nota + (1/n)*cos(2*pi*n*frek*tt);                           %Harmonikler toplanır
 end

 if(zarf==1)    
     %ADSR
     len  = length(nota);
     env  = [linspace(0,1.5,ceil(len/5)) linspace(1.5,1,ceil(len/10)) ...   %ADSR zarfı oluşturulur
            ones(1,ceil(len/2)) linspace(1,0,ceil(len/5))];                 
     fark = length(env) - length(nota);                               
     env  = env(1,1:end-fark);
     nota = nota.*env;                                                      %ADSR zarfı ilgili notaya uygulanır
                                                 
 elseif(zarf==2)   
      %Exponential 
      ttt = 0:1/fs:dur-1/fs;
      nota = nota.*exp(-ttt/parse(i,2));                                     %Exponential zarfı ilgili notaya uygulanır     
 end
      signal  = horzcat(signal,nota);                                       %nota , sinyal dizisinin sonuna eklenir
      time    = horzcat(time,tt);                                           %nota süresi , time dizisinin sonuna eklenir
  end

 reverb    =  reverberator('PreDelay',0.5,'WetDryMix',1);                   %reverberator nesnesi oluşturulur 'reverb'
 revSig    =  reverb(signal');                                              %Sonuç sinyale reverb eklenir
 plot(time,signal)                                                          %reverb eklenmemiş sinyal çizilir
 legend('Signal')
 title('Reverb eklenmemiş Sinyal');
 figure
 plot(time,revSig)                                                          %reverb eklenen sinyal çizilir
 legend('Signal','Reverb')
 title('Reverb eklenmiş Sinyal');
 %soundsc(revSig,fs);                                                        %reverb eklenen sinyal çalınır
 
 
 