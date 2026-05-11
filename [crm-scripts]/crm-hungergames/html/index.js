$(function () {
    $("body").hide();
    window.addEventListener('message', function(event) {
        let text = document.getElementById("text")
        let text2 = document.getElementById("kills")
        let winningsound = this.document.getElementById("winningsound")
        let text3 = document.getElementById("players")
        let textwins = document.getElementById("winstop")
        var item = event.data;
        if (item.type === "text") {
            $("body").fadeIn();
            $("#text").fadeIn();
            if (item.text == 'Victory') {
                winningsound.load()
                winningsound.play();
                winningsound.volume = 0.28;
            }
            text.innerText = item.text
            setTimeout(function() {
                $("#text").fadeOut();
                winningsound.pause();
            }, 4800);
        }    

        if (item.type == 'lobbyscreen') {
            $("body").fadeIn();
            $('#leaderboarddiv').hide();
            $('#hud').hide();
            $('#container').hide();
            $('#lobbyscreen').show();
            textwins.innerText = 'WINS: ' + item.wins
        }

        if (item.type === "ui") {
            $('#lobbyscreen').hide();
            $("body").fadeIn();
            $('#hud').fadeIn();
            $('#container').fadeIn();
            if (item.Kills == undefined) {
                text2.innerText = 'Kills : 0'
            }else{
                text2.innerText = 'Kills : ' + item.Kills
            }
            if (item.Playersingame == undefined) {
                text3.innerText = 'Alive'
            }else {
                text3.innerText = 'Alive : ' + item.Playersingame + '/12'
            }

        }  
        
        if (item.type === "uihide") {
            $("body").fadeOut();
        }   
         

        if (item.type === "topdata") {
            var nameDiv = $('<div>').text(item.name);
            var winsDiv = $('<div>').text(item.wins);
            var topDiv = $('<div>').text(item.Topid + ".");
            $('#namep').append(nameDiv);
            $('#winsp').append(winsDiv);
            $('#topnumberid').append(topDiv);
        }  
    })   
})





function play(){
    $('#leaderboarddiv').hide();
    $('#gameselector').fadeIn();
}

function join(){
    $.post(`https://${GetParentResourceName()}/joingame`);
}

function leave(){
    $("body").hide();
    $.post(`https://${GetParentResourceName()}/leavelobby`);
}

function board(){
    $.post(`https://${GetParentResourceName()}/dataleaderboard`);
    $('#gameselector').hide();
    $('#leaderboarddiv').fadeIn();
    $('#namep').html("");
    $('#topnumberid').html("");
    $('#winsp').html("");
}

