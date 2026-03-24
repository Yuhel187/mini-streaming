import { Injectable } from "@nestjs/common";

@Injectable()
export class VideoService {
  getPing(): { message: string } {
    return { message: 'pong' };
  }
}