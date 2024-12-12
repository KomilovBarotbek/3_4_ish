const readline = require('readline');
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});
rl.question("a ni kiriting: ",(a) => {
    rl.question("b ni kiritng: ",(b) => {
        let sum = 0;
        for(let i = a; i < b; i++){
            sum += i * i;
            rl.close();   
        }
        console.log(`a dan b gacha sonlar yig\'indisi ${sum}`);
    })
})