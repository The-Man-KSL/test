window.onload = function(e) {
    window.addEventListener('message', function(event) {
        let data = event.data
        $('body').show();
      
    })
}     
    $("#close").click(function (data)  {
            $("body").hide();
            $.post('http://crm-name/exit', JSON.stringify({}));
            return
        })


    $("#submit").click(function () {
        let inputValue = $("#firstname").val()
        let inputValue2 = $("#lastname").val()
        if (inputValue.length >= 10 && inputValue2.lenght >= 10){
            $.post("http://crm-name/error", JSON.stringify({
                error: "Du kannst nicht so viele Zeichen eingeben."
            }))
            return
        } else if (!inputValue && !inputValue2) {
            $.post("http://crm-name/error", JSON.stringify({
                error: "Vorgang abgebrochen"
            }))
            return
        }
        

        $('body').hide();
        $.post('http://crm-name/join', JSON.stringify({
            vorname: inputValue,
            nachname: inputValue2,
            
        }));
   
    })
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $("body").hide();
            $.post('http://crm-name/exit', JSON.stringify({}));
            return
        }
    };


   





