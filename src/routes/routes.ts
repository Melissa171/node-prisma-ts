import { FastifyInstance } from 'fastify';
import { prisma } from '../lib/prisma';
import { z } from 'zod';

export async function userRoutes(api: FastifyInstance) {
	// requisição main;
	api.get('/', async (_, rep) => {
		return rep.send({
			message: 'you are at home.'
		});
	});

	// buscar usuários;
	api.get('/users', async (req, rep) => {
		const users = await prisma.user.findMany();
		return rep.send({
			message: 'requisição feita com sucesso.',
			users
		});
	});

	// buscar usuário por id;
	api.get('/users/:id', async (req, rep) => {
		const idSchema = z.object({
			id: z.string()
		});

		const { id } = idSchema.parse(req.params);

		const returnedUser = await prisma.user.findUnique({
			where:{
				id
			}
		});

		return rep.send({
			message: 'usuário encontrado',
			returnedUser
		});
	});

	// registrar usuário;
	api.post('/register/user', async (req, rep) => {
		const userSchema = z.object({
			user: z.string(),
			email: z.string(),
			password: z.string(),
			date_of_birthday: z.string(),
			cpf: z.string(),
		});

		const content = userSchema.parse(req.body);
		const newUser = await prisma.user.create({
			data: {
				user: content.user,
				email: content.email,
				password: content.password,
				date_of_birthday: content.date_of_birthday,
				cpf: content.cpf
			}
		});

		return rep.code(200).send({
			message: 'requisição feita com sucesso',
			newUser
		});
	});

	// Registrar cartão de crédito;
	api.post('/register/cc', async (req, rep) => {
		const ccSchema = z.object({
			userId: z.string(),
			nt: z.string(),
			cn: z.string(),
			validate: z.string(),
			cvv: z.string()
		});

		const content = ccSchema.parse(req.body);

		const userExists = await prisma.user.findUnique({
			where: {
				id: content.userId
			}
		});


		if(userExists){
			try {
				const newCC = await prisma.cC.create({
					data: {
						userId: content.userId,
						NT: content.nt,
						CN: content.cn,
						Validate: content.validate,
						CVV: content.cvv
					}
				});
	
				return rep.code(200).send({
					message: 'Cartão adicionado com sucesso.',
					newCC
				});
			} catch (err){
				return rep.code(500).send({
					message: 'Erro ao adicionar cartão',
					err
				});
			}
		}else {
			rep.code(500).send({
				message: 'Erro ao adicionar cartão',
				error: 'Não existe usuário com este id.'
			});
		}
	});

	// Listar todas os cartões do banco de dados;
	api.get('/users/cc', async (req, rep) => {
		const cc = await prisma.cC.findMany();

		rep.code(200).send({
			message: 'requisição feita com sucesso',
			cc
		});
	});

	// Procurar cartão de crédito por nome de usuário;
	api.get('/users/cc/:user', async (req, rep) => {
		const userParamSchema = z.object({
			user: z.string()
		});

		const { user } = userParamSchema.parse(req.params);
		const userExists = await prisma.user.findUnique({
			where: {
				user
			}
		});

		if(userExists){
			const getCC = await prisma.cC.findMany({
				where: {
					userId: userExists.id
				}
			});

			if(getCC[0]){
				return rep.code(200).send({
					message: 'cc encontrada',
					getCC
				});
			}else{
				return rep.code(200).send({
					message: 'usuário não tem cc cadastrado'
				});
			}
			
		}else {
			return rep.code(500).send({
				message: 'usuário não existe'
			});
		}
	});
}