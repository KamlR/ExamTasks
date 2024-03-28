import { Request, Response, NextFunction } from 'express';
const jwt = require('jsonwebtoken');

const secretKey = "qmpLre49#ax1"
interface MyRequest extends Request {
    login?: string; // Предположим, что информация о логине - строка
}

class AuthMiddleware {
  static verifyToken(req: Request, res: Response, next: NextFunction) {
    const authHeader = req.headers.authorization;
    if (!authHeader) {
      return res.status(400).json({ error: 'Отсутствует токен авторизации' });
    }
    const token = authHeader.split(' ')[1];
    if (!token) {
      return res.status(400).json({ error: 'Отсутствует токен авторизации' });
    }

    jwt.verify(token, secretKey, (err: any, decoded: any) => {
        if (err) {
            if (err.name === 'TokenExpiredError') {
                return res.status(401).json({ error: 'Истек срок действия токена авторизации' });
            }
            return res.status(400).json({ error: 'Неверный токен авторизации' });
          }
        (req as any).login = decoded.login;
        next();
    });
  }
}
export default AuthMiddleware;