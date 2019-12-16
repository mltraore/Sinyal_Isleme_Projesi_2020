 **Kişisel Bilgileri** <br/>

Öğrenci Ad-Soyad : Mohamed TRAORE<br/>
Öğrenci   Numara : 030117024  <br/>
Ders Adı         : Sinyal İşleme<br/>
Proje            : MATLAB ile sentezleme<br/>

**1. Hafta Hedefleri** <br/>
-Müzik notasyon programı olan MuseCore ortamında oluşturulan müziğin MATLAB ortamında parse edilmesi.<br/>
-Müziği sentezlemek üzere note.m ve sentez.m MATLAB dosyalarının oluşturulması. <br/>
-Parse edilmiş datanın incelenmesi ve müziğin sentezleyebilmesi içi lazım olan sütunların tespit edilmesi.<br/>
-Repoya .musicxml .mscz uzantılı müzik dosyaları ve .png uzantılı foto dosyasının eklenmesi.<br/>
  **CEVAPLAR** <br/> 
1. Oluşturulan müziğin .png dosyası <br/>

   ![](images/nota.png) <br/>

   Bu müzik 16 ölçülüklü olmak üzere 229 nota ve restten  oluşmaktadır. <br/>
   1.Ölçülük (9 tane nota ve 2 tane restten oluşmaktadır)<br/>

   ![](images/olculuk.png) <br/>

  

2. .musicxml uzantılı dosyanın parse edilmesi <br/>

     MusicXML Parser fonksiyonu kullanılarak oluşturulan müzik parse edilir.<br/>
     mxml = parseMusicXML('/home/mohamedlassine/Bureau/Sinyal_Isleme_Projesi_2020/muzik/nota.musicxml');<br/>

3.   Müziği sentezleyebilmek için verinin lazım olan sütunları<br/>
 
     notanın trigonometrik formülü : A*cos(2*pi*f*t)<br/>
          - A : notanın genliği<br/>
          - f : notanın frekansı<br/>
          - t : notanın çalma zamanı (başlangıç , bitiş zamanı ve örnekleme frekansı ile bulunur)<br/>
     dolayısıyla lazım olan sütunlar bunlardır : <br/>
          4.Sütun: her bir notanın middi pitch değerini vermektedir ve bu değeri frekansa çevirilerek notanun freakansı bulunur.<br/>
                    \begin{equation}
                  <pre> formül : f = 440*2^((pitch - 69)/12)  Hz </pre> <br/>
                    \end{equation}
          5.Sütun: Saniye cinsinden her notanın başlangıç zamanını vermektedir.<br/>
          6.Sütun: Saniye cinsinden her natanın ne kadar zaman sürdüğünü vermektedir. Bu değeri kullanarak bitiş zamanı bulunur.<br/>
                   bitiş zaman = başlangıç + süre <br/>

     Parse edilmiş Müzik örneği                                                   <br/>
     1.Ölçülük parse verileri(Sentezleme için lazım olan sütunlar belirlenmiştir) <br/>
    
     ![](images/parse.png)
     <br/>
**2. Hafta Hedefleri**

-sentez.m scripti.<br/>
-Exponential ve ADSR zarfların kullanılması. <br/>
-Harmonik eklenmesi.<br/>
-MATLAB'ın reverberation fonksiyonunu kullanarak yankı eklenmesi.<br/>
-Program sonunda sinyal ve reverb eklenen olan sinyalin çizilmesi. <br/>
-Program sonunda reverb eklenen sinyalin çaldırılması. <br/>
-16. Ölçülükteki notaların harmonik eklenmeden eklenmiş ve reverb eklenmiş versiyonlarının grafikleri çıkartıp açıklamalara eklenmesi. <br/>

**CEVAPLAR**



