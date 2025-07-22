import { Test, TestingModule } from '@nestjs/testing';
import { CarImageController } from './car-image.controller';

describe('CarImageController', () => {
  let controller: CarImageController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [CarImageController],
    }).compile();

    controller = module.get<CarImageController>(CarImageController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
