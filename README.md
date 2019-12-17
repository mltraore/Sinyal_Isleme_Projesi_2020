 <h1>Kişisel Bilgileri</h1> <br/>

Öğrenci Ad-Soyad : Mohamed TRAORE<br/>
Öğrenci   Numara : 030117024  <br/>
Ders Adı         : Sinyal İşleme<br/>
Proje            : MATLAB ile sentezleme<br/>

<h1>1. Hafta Hedefleri</h1> <br/>
-Müzik notasyon programı olan MuseCore ortamında oluşturulan müziğin MATLAB ortamında parse edilmesi.<br/>
-Müziği sentezlemek üzere note.m ve sentez.m MATLAB dosyalarının oluşturulması. <br/>
-Parse edilmiş datanın incelenmesi ve müziğin sentezleyebilmesi içi lazım olan sütunların tespit edilmesi.<br/>
-Repoya .musicxml .mscz uzantılı müzik dosyaları ve .png uzantılı foto dosyasının eklenmesi.<br/>
  <h1>CEVAPLAR</h1> <br/> 
<h2>1. Oluşturulan müziğin .png dosyası</h2> <br/>

   ![](images/Nota.png) <br/>

   Bu müzik 16 ölçülüklü olmak üzere 229 nota ve restten  oluşmaktadır. <br/>
   1.Ölçülük (9 tane nota ve 2 tane restten oluşmaktadır)<br/>

   ![](images/Olculuk.png) <br/>

<h2>2. .musicxml uzantılı dosyanın parse edilmesi</h2> <br/>

     MusicXML Parser fonksiyonu kullanılarak oluşturulan müzik parse edilir.<br/>
     mxml = parseMusicXML('nota.musicxml');<br/>

<h2>3.   Müziği sentezleyebilmek için verinin lazım olan sütunları</h2> <br/>
 
     notanın trigonometrik formülü : A*cos(2*pi*f*t)<br/>
          - A : notanın genliği<br/>
          - f : notanın frekansı<br/>
          - t : notanın çalma zamanı (başlangıç , bitiş zamanı ve örnekleme frekansı ile bulunur)<br/>
     dolayısıyla lazım olan sütunlar bunlardır : <br/>
          4.Sütun: her bir notanın middi pitch değerini vermektedir ve bu değeri frekansa çevirilerek notanun freakansı bulunur.<br/>
                   
                  <pre> formül   frekans = 440*2^((pitch - 69)/12)  Hz </pre> 
                  
          5.Sütun: Saniye cinsinden her notanın başlangıç zamanını vermektedir.<br/>
          6.Sütun: Saniye cinsinden her natanın ne kadar zaman sürdüğünü vermektedir. Bu değeri kullanarak bitiş zamanı bulunur.<br/>
                   bitiş zaman = başlangıç + süre <br/>

     Parse edilmiş Müzik örneği                                                   <br/>
     1.Ölçülük parse verileri(Sentezleme için lazım olan sütunlar belirlenmiştir) <br/>
    
     ![](images/Parse.png)

     <br/>
<h1>2. Hafta Hedefleri</h1>

-sentez.m scripti.<br/>
-Exponential ve ADSR zarfların kullanılması. <br/>
-Harmonik eklenmesi.<br/>
-MATLAB'ın reverberation fonksiyonunu kullanarak yankı eklenmesi.<br/>
-Program sonunda sinyal ve reverb eklenen olan sinyalin çizdirilmesi. <br/>
-Program sonunda reverb eklenen sinyalin çaldırılması. <br/>
-16. Ölçülükteki notaların harmonik eklenmeden eklenmiş ve reverb eklenmiş versiyonlarının grafikleri çıkartıp açıklamalara eklenmesi. <br/>

<h1>CEVAPLAR</h1> <br/>

<h2>1. sentez.m scripti</h2> <br/>

<pre>


parse  = parseMusicXML('nota.musicxml');                                    %Müzik parse edilir
zarf   = input('Zarf turunu seciniz : 1->exponential 2->ADSR : ');
hmk    = input('Harmonik sayisini giriniz : ');
fs     = 44100;                                                             %Örnekleme frekansı 44100 Hz
signal = [];
revSig = []; 
time   = [];
tt     = [];


for i  = 1:length(parse)
 frek  = note(parse(i,4));                                                  %Pitch'ten frekans döndürülür
 start = parse(i,6);
 dur   = parse(i,7);
 tt    = start:1/fs:(start+dur-1/fs);
 nota  = zeros(size(tt));
 
 for n = 1:hmk
         nota = nota + (1/n)*cos(2*pi*n*frek*tt);                           %Harmonikler toplanır
 end

 if(zarf==1)
     %Exponential
     nota = nota.*exp(-tt/parse(i,2));                                      %Exponential zarfı ilgili notaya uygulanır
 elseif(zarf==2) 
     %ADSR
     len  = length(nota);
     env  = [linspace(0,1.5,ceil(len/5)) linspace(1.5,1,ceil(len/10)) ...   %ADSR zarfı oluşturulur
            ones(1,ceil(len/2)) linspace(1,0,ceil(len/5))];                 
     fark = length(env) - length(nota); 
     env  = env(1,1:end-fark);
     nota = nota.*env;                                                      %ADSR zarfı ilgili notaya uygulanır
  end
  signal  = horzcat(signal,nota);                                           %nota , sinyal dizisinin sonuna eklenir
  time    = horzcat(time,tt);                                               %nota süresi , time dizisinin sonuna eklenir
end
 
 reverb   =  reverberator('PreDelay',0.5,'WetDryMix',1);                    %reverberator nesnesi oluşturulur 'reverb'
 revSig   =  reverb(signal');                                               %Sonuç sinyale reverb eklenir
 plot(time,signal)                                                          %reverb eklenmemiş sinyal çizilir
 legend('Signal')
 figure
 plot(time,revSig)                                                          %reverb eklenen sinyal çizilir
 legend('Signal','Reverb')
 soundsc(revSig,fs);                                                        %reverb eklenen sinyal çaldırılır

</pre>

<h2>2.1 Notaya exponential zarfının uygulanması</h2>

<pre>
     nota = nota.*exp(-tt/parse(i,2));                                       %Exponential zarfı ilgili notaya uygulanır
</pre>


<h2>2.2 Notaya ADSR zarfının uygulanması  </h2>

<pre>
    %ADSR
     len  = length(nota);
     env  = [linspace(0,1.5,ceil(len/5)) linspace(1.5,1,ceil(len/10)) ...   %ADSR zarfı oluşturulur
            ones(1,ceil(len/2)) linspace(1,0,ceil(len/5))];                 
     fark = length(env) - length(nota); 
     env  = env(1,1:end-fark);
     nota = nota.*env;                                                      %ADSR zarfı ilgili notaya uygulanır
</pre>

<h2>3 Harmonik eklenmesi </h2>

<pre>
     for n = 1:hmk
         nota = nota + (1/n)*cos(2*pi*n*frek*tt);                           %Harmonikler toplanır
     end
</pre>

<h2>4 MATLAB'ın reverberation fonksiyonunu kullanarak yankı eklenmesi. </h2>

<pre>
     reverb   =  reverberator('PreDelay',0.5,'WetDryMix',1);                    %reverberator nesnesi oluşturulur 'reverb'
     revSig   =  reverb(signal');                                               %Sonuç sinyale reverb eklenir
</pre>

<h2>5.1 Reverb eklenmemiş Sinyal grafiği (ADSR)</h2>



<h2>5.2 Reverb eklenmiş Sinyal grafiği   (ADSR)</h2>



<h3> Not : </h3>


<h2>6 Reverb eklenen sinyalin çaldılırma </h2>

<pre>
      soundsc(revSig,fs);                                                        %reverb eklenen sinyal çaldırılır
</pre>


<h2> 16.Ölçülük : </h2> <br/>

<h3> Harmonik eklenmemiş (ADSR)</h3>

   ![](images/harmoniksiz.jpg) 

<h3> Harmonik eklenmiş   (ADSR)</h3>

   ![](images/harmonik_100.jpg)

<h3> reverb eklenmiş (harmoniksiz)    (ADSR)</h3>

   ![](images/reverbNoHarmonic.jpg)

<h3> reverb eklenmiş (harmonik=100)    (ADSR)</h3>

   ![](images/reverbHarmonic_100.jpg)

<br/>

<h3> Not : </h3>




