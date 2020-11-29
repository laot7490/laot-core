# LAOTCore v1.1.3

[Clientside]
```lua

LAOT = nil

Citizen.CreateThread(function()
	while LAOT == nil do
		TriggerEvent('LAOTCore:getSharedObject', function(obj) LAOT = obj end)
		Citizen.Wait(0)
	end
end)
```

[Serverside]
```lua

LAOT = nil

TriggerEvent('LAOTCore:getSharedObject', function(obj) LAOT = obj end)
```

## LAOTCore Nedir?
###### LAOTCore yazdığım scriptlerde kullandığım altyapı sistemi denilebilir. Ayrıca içinde bulunan bir çok fonksiyon ile çoğu developera kısayol sunuyor.

## Neden kullanıyorsun?
###### Sistemin bana verdiği çok kısayol bulunuyor, ayrıca istediğim zaman içindeki fonksiyonları tek olarak değiştirince diğer sistemleri tek tek değiştirmeme gerek kalmıyor.

## Neden böyle bir bilgilendirme metni var?
###### Bilgilendirme metini bundan sonra paylaşılan veya satılan sistemlerin yanında bu scriptin kullanılma zorunluluğu olacağından dolayıdır.

## Güncellendiğinde eski versiyonda olanlar ne yapacak?
###### Çoğu script LAOTCore sistemi ile birlikte güncellenecek eski versiyonda kalanlara konsol üzerinden uyarısını verecek. Ancak kullanmayan olursa yeni sistemlerden mahrum kalacak. Onun dışında eski versiyonu kullanmaya devam edebilirler.

# Örnekler ve Bilgilendirme

###### Bir bölgeye yakınken 3D yazı yazma
```lua
Citizen.CreateThread(function()
	while LAOT == nil do -- LAOT datasının yüklenmesini bekliyoruz...
		Citizen.Wait(10)
	end
	while true do
		local sleep = 1000 -- her 1 saniyede bir kontrol etme
		if Vdist2(GetEntityCoords(PlayerPedId()), lokasyon.x, lokasyon.y, lokasyon.z) <= 15 then -- Eğer belirttiğimiz kordinattan oyuncu 15 blok yakınlığındaysa...
			sleep = 1 -- Her frame çizdirmemiz gerekiyor.
			LAOT.DrawText3D(lokasyon.x, lokasyon.y, lokasyon.z, "~g~E ~w~- Satin Al", 0.40) -- Lokasyona satın al yazdırdık.
		end
		Citizen.Wait(sleep)
	end
end)
```

![Örnek sonucu](https://cdn.discordapp.com/attachments/754629142502441051/782118333213311026/3D.png)

###### Bir bölgeye yakınken GTA Altyazı metini yazmak

```lua
Citizen.CreateThread(function()
	while LAOT == nil do -- LAOT datasının yüklenmesini bekliyoruz...
		Citizen.Wait(10)
	end
	while true do
		local sleep = 1000 -- her 1 saniyede bir kontrol etme
		if Vdist2(GetEntityCoords(PlayerPedId()), lokasyon.x, lokasyon.y, lokasyon.z) <= 15 then -- Eğer belirttiğimiz kordinattan oyuncu 15 blok yakınlığındaysa...
			LAOT.DrawSubtitle("~o~GPS'te ~w~belirtilen alana git.", 1000) -- 1 saniye boyunca yazdırıyoruz...
		end
		Citizen.Wait(sleep)
	end
end)
```

![Örnek sonucu](https://cdn.discordapp.com/attachments/754629142502441051/782117838123040788/GPS.png)

###### Bir bölgede [E] basınca oyuncuyu kararma efekti ile ışınlamak
```lua
Citizen.CreateThread(function()
	while LAOT == nil do -- LAOT datasının yüklenmesini bekliyoruz...
		Citizen.Wait(10)
	end
	while true do
		local sleep = 1000 -- her 1 saniyede bir kontrol etme
		if Vdist2(GetEntityCoords(PlayerPedId()), lokasyon.x, lokasyon.y, lokasyon.z) <= 10 then -- Eğer belirttiğimiz kordinattan oyuncu 15 blok yakınlığındaysa...
			sleep = 1
			if IsControlJustPressed(0, 38) then -- Oyuncu E basarsa
				LAOT.Game.Teleport(1000, teleport.x, teleport.y, teleport.z, teleport.h, function()
					LAOT.Notification("inform", "Başarı ile ışınlandınız.") -- 1 saniye kararma efekti ile oyuncuyu ışınladık.
				end)
			end
		end
		Citizen.Wait(sleep)
	end
end)
```
