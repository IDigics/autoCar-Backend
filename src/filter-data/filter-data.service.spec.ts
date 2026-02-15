import { Test, TestingModule } from '@nestjs/testing';
import { FilterDataService } from './filter-data.service';

describe('FilterDataService', () => {
  let service: FilterDataService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [FilterDataService],
    }).compile();

    service = module.get<FilterDataService>(FilterDataService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
