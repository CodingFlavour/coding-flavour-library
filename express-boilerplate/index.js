import Logger from '@coding-flavour/logger';
import cors from 'cors';
import express from 'express';

const app = express();
app.use(express.json());
// @TODO: This will be handled by @coding-flavour/security
app.use(cors({
    origin: '*',
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
}));
const port = 3000; // Or use any port you prefer, or get it from environment variables
const logger = Logger('Coding Flavour Control Panel Server');

// @TODO: Install @coding-flavour/security to inject protection middlewares to the endpoints
function initServer() {
    /* Add your endpoints here */
    /* End of endpoints */

    logger.log(`Welcome to Coding Flavour Control Panel Server!`, { keepLevel: true });
    logger.log(`We are now trying to open the server, wait a minute...`);

    doListen(port)
}

function doListen(port) {
    // favicon
    logger.log(`Trying to open server on port ${port}`);

    app.listen(port, () => logger.log(`Server listening on port ${port}`, { subtractLevel: true })).on('error', () => {
        logger.log(`Port already in use: ${port}; trying ${port + 1}`, { subtractLevel: true });
        doListen(port + 1)
    });
}

initServer();