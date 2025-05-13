import { Router } from "express";
import {
  getData,
  getErrors,
  getErrorById,
} from "../controllers/errors.controller.js";

const router = Router();

router.get("/data", getData);

router.get("/errors", getErrors);

router.get("/errors/:id", getErrorById);


export default router;
