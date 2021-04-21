$(function () {
    window.onload = (e) => {

      window.addEventListener("message", (event) => {
        var item = event.data;
        if (item !== undefined && item.type === "custom") {
          document.getElementById("notifications").innerHTML +=
            '<div class="notification" style="border-left: 5px ' +
            item.color +
            ' solid;"><div class="notification-title"><p id="notfication-title-content">' +
            item.text + "";
          $(".notification").delay(5000).fadeOut("slow");
        }
      });
      
    };
  });