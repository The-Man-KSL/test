$(function () {
    $("body").show()
    $('.TurfUi').hide()
    $('.nametimercontainer').hide()
    window.addEventListener('message', function (event) {
        if (event.data.type == "update") {
            if (event.data && event.data.data && event.data.data.gang.name != null) {
                $("body").show();
                $("#content").find("span").html(event.data.data.gang.label + " - " + event.data.data.rank.label)
                if (event.data.logo != null) {
                    $("#gangLogo").attr("src", event.data.logo)
                } else {
                    $("#gangLogo").attr("src", "logo.png")
                }
            } else {
                $("body").hide()

            }
        }
        if (event.data.type == "time") {
            $(".time").text(event.data.time)
            $(".namo").text(event.data.name)
            $(".TurfName").text(event.data.name)
            $("#kills").html(`<i class="fa-solid fa-gun" style="color: rgba(255, 255, 255); font-size: 14px;"></i> ${event.data.kills}`)
            $("#money").html(`<i class="fa-solid fa-sack-dollar" style="color: rgba(255, 255, 255); font-size: 14px;"></i> ${event.data.money}`)
            $(".lineover").css('width', event.data.timeee + "%")

        }
        if (event.data.type == "hide") {
            $('.TurfUi').hide()
            $('.nametimercontainer').hide()

        }
        if (event.data.type == "show") {
            $('.TurfUi').show()
            $('.nametimercontainer').show()

        }

        var v = event.data;

        switch(v.action) {
            case 'ShowGangTurfUI':
                if (v.toggle_gang == true) {
                    $('.gangTurfUi').fadeIn(100);
                    $('#turfUiLabel').html(`<i class="fa-solid fa-crosshairs" style="margin-right: 5px;"></i>` + v.turfLabel);
                    $('#turfUiTimer').html(`<i class="fa-solid fa-clock" style="margin-right: 5px;"></i>` + v.turfTimer);
                    $('#turfUiKills').html(`<i class="fa-solid fa-skull" style="margin-right: 5px;"></i>` + v.turfKills);
                    $('#turfUiMoney').html(`<i class="fa-solid fa-dollar-sign" style="margin-right: 5px;"></i>` + v.turfMoney);
                } else if (v.toggle_gang == false) {
                    $('.gangTurfUi').fadeOut(100);
                }
            break;
        }
    });
});