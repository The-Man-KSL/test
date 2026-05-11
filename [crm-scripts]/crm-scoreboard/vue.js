const app = new Vue({
  el: '#app',
  data: {
    ui:false,
    time:{},
    job:{mechanic:0, ambulance:0, police:0, all:0},
    currentDate: new Date(),
    profile:{
      //  background:"https://media.discordapp.net/attachments/627114895183446016/1139606633199190107/police_background.png",
      // "id":"28","job":"police","ping":148,"onDuty":true,"group":{"admin":true,"god":true,"mod":true},"lastname":"Test","salary":75,"avatar":"https://avatars.dicebear.com/api/human/5253.svg","cash":205448,"bank":207860,"grade":"Officer","name":"Raider"
    },
    heist:[
      {
        header:'The Diamond Casino',
        label:'NOW OPEN!',
        description:'Head over to the Diamond Casino today to hangout with other Los Santos civillians or if you are feeling lucky you can always have a go at gambling!',
      },
      {
        header:'Ocean Hospital',
        label:'JUST BUILT!',
        description:'The pillbox hospital staff have came across a huge amount of money and opened a new big hospital to treat their patients better!',
      },
      {
        header:'Cayo Perico',
        label:'DRUG ISLAND',
        description:'There have been stories about a drug island being located near Los Santos by the name of Cayo Perico, it sounds very dangerous.',
      },
      {
        header:'Mall',
        label:'VERONICA MALL',
        description:'A new mall has been opened featuring stores such as Starbucks, Dunkin Donuts, Gucci and more!',
      }
    ],
    update:[
      {
      header:'Update Notes v1.0',
      description:'LS Semi ESX is released!'
      },
      {
        header:'Update Notes v1.0',
        description:'More updates coming soon!'
      },
      {
          header:'Update Notes v1.0',
          description:'More updates coming soon!'
      },
      {
        header:'Update Notes v1.0',
        description:'More updates coming soon!'
    }
    ],
    players:[],
    idColors: {}
  },
   methods: {
    
    capitalizeFirstLetter(text) {
      return text ? text.charAt(0).toUpperCase() + text.slice(1) : '';
    },

    randomColor() {
      return `rgb(${Math.floor(Math.random() * 256)}, ${Math.floor(Math.random() * 256)}, ${Math.floor(Math.random() * 256)})`;
    },
    randomGradient() {
      return `linear-gradient(90deg, ${this.randomColor()} 0%, rgb(255, 255, 255) 100%)`;
    },
    randomTextShadow() {
      const x = Math.floor(Math.random() * 5) - 2;  // -2px to 2px
      const y = Math.floor(Math.random() * 5) - 2;  // -2px to 2px
      return `${x}px ${y}px 5px rgba(0, 0, 0, 0.2)`;
    },

    getRandomColor() {
      const lightHexValues = '89ABCDEF'; 
      let color = '#';
      for (let i = 0; i < 6; i++) {
        color += lightHexValues[Math.floor(Math.random() * lightHexValues.length)];
      }
      return color;
    },
    
    assignColorsToIds() {
      this.players.forEach(player => {
        let newColor;
        do {
          newColor = this.getRandomColor();
        } while (Object.values(this.idColors).includes(newColor));
        this.$set(this.idColors, player.id, newColor);
      });
    }
   },

   computed: {
    formattedDate() {
      const day = this.currentDate.getDate();
      const month = this.currentDate.getMonth() + 1;
      const year = this.currentDate.getFullYear();
      return `${day}/${month}/${year}`;
    },
    computedColors() {
      return this.update.map(() => {
        return this.randomColor();
      });
    },
    computedStyles() {
      return this.update.map(() => {
        return {
          background: this.randomGradient(),
          textShadow: this.randomTextShadow(),
          '-webkit-background-clip': 'text',
          '-webkit-text-fill-color': 'transparent',
          'background-clip': 'text'
        };
      });
    }
  },
   players: {
    handler: function(after) {
      after.forEach(player => {
        if (!this.idColors[player.id]) {
          let newColor;
          do {
            newColor = this.getRandomColor();
          } while (Object.values(this.idColors).includes(newColor));
          this.$set(this.idColors, player.id, newColor);
        }
      });
    },
    deep: true
  },
  created(){
    var self = this;
    window.addEventListener('message', function(event) {
      var item = event.data;
      switch (item.type) {
        case "MENU":
            console.log(JSON.stringify(item))
            self.ui = true;
            self.players = item.users;
            self.job = item.jobs;
            self.profile = item.data;
            console.log(" Profile " + JSON.stringify(self.profile))
          break
          case "TIMER":
            self.time = item.clock;
          break
      }
  });
  },
   mounted(){
     this.assignColorsToIds();
   }
})

function capitalizeFirstLetter(text) {
  return text.charAt(0).toUpperCase() + text.slice(1);
}

function typeMoney(value) {
  return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
  }).format(value);
}

  document.onkeyup = function (data) {
    if (data.which == 27) {
    app.ui = false;
    $.post(`https://${GetParentResourceName()}/exit`, JSON.stringify({}));
    }
  };


