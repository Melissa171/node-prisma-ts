import fastify from 'fastify';
import cors from '@fastify/cors';
import { userRoutes } from './routes/routes';

const api = fastify();
api.register(cors, {
	origin: true
});

api.register(userRoutes);

api.listen({
	host: '0.0.0.0',
	port: 1171
}).then(() => {
	console.log('👻 HTTP server running on http://localhost:1171 👻');
});