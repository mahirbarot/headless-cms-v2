"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = ({ env }) => ({
    host: env('HOST', '0.0.0.0'),
    port: env.int('PORT', env.int('$PORT', 1337)), // Support Railway's $PORT
    app: {
        keys: env.array('APP_KEYS'),
    },
});
