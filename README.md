# Nasıl kullanılır?

**client-side**
```
LAOT = nil

Citizen.CreateThread(function()
	while LAOT == nil do
		TriggerEvent('LAOTCore:getSharedObject', function(obj) LAOT = obj end)
		Citizen.Wait(0)
	end
end)
```

**server-side**
```
LAOT = nil

TriggerEvent('LAOTCore:getSharedObject', function(obj) LAOT = obj end)
```

# Soru ve Cevap

## LAOTCore Nedir?
###### LAOTCore yazdığım scriptlerde kullandığım altyapı sistemi denilebilir. Ayrıca içinde bulunan bir çok fonksiyon ile çoğu developera kısayol sunuyor.

## Neden kullanıyorsun?
###### Sistemin bana verdiği çok kısayol bulunuyor, ayrıca istediğim zaman içindeki fonksiyonları tek olarak değiştirince diğer sistemleri tek tek değiştirmeme gerek kalmıyor.

## Neden böyle bir bilgilendirme metni var?
###### Bilgilendirme metini bundan sonra paylaşılan veya satılan sistemlerin yanında bu scriptin kullanılma zorunluluğu olacağından dolayıdır.

## Güncellendiğinde eski versiyonda olanlar ne yapacak?
###### Çoğu script LAOTCore sistemi ile birlikte güncellenecek eski versiyonda kalanlara konsol üzerinden uyarısını verecek. Ancak kullanmayan olursa yeni sistemlerden mahrum kalacak. Onun dışında eski versiyonu kullanmaya devam edebilirler.
