# LAOTCore v1.1.2

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
			LAOT.DrawText3D(lokasyon.x, lokasyon.y, lokasyon.z, "~g~E ~w~- Satin Al") -- Lokasyona satın al yazdırdık.
		end
		Citizen.Wait(sleep)
	end
end)
```

###### Bir bölgeye yakınken GTA Online Alt yazı metini yazma

![Örnek sonucu](https://cdn.discordapp.com/attachments/754629142502441051/782117838123040788/GPS.png)

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
