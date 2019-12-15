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

   ![nota](/uploads/85ae517f20d28ee1a8801ac7a5251c26/nota.png)

   Bu müzik 16 ölçülüklü olmak üzere 229 nota ve restten  oluşmaktadır. <br/>
   1.Ölçülük (9 tane nota ve 2 tane restten oluşmaktadır)<br/>

   ![olculuk](/uploads/d35f81d78e38a77cae3ec5d43cb5d5ab/olculuk.png) <br/>

  

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
                  <pre> formül :  f = 440*2^((pitch - 69)/12)  Hz </pre> <br/>
          5.Sütun: Saniye cinsinden her notanın başlangıç zamanını vermektedir.<br/>
          6.Sütun: Saniye cinsinden her natanın ne kadar zaman sürdüğünü vermektedir. Bu değeri kullanarak bitiş zamanı bulunur.<br/>
                   bitiş zaman = başlangıç + süre <br/>

     Parse edilmiş Müzik örneği                                                   <br/>
     1.Ölçülük parse verileri(Sentezleme için lazım olan sütunlar belirlenmiştir) <br/>
    
     ![parse](/uploads/e91bba8d4ed0d75dcecec68cd30b7d0b/parse.png)
     <br/>
**2. Hafta Hedefleri**

