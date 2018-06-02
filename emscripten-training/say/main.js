function main() {
    var module = require('./api_say.js');
    module._say();

    var say = module.cwrap('say');
    say();
}

main();
