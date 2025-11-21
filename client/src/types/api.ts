export interface BaseResponse<T> {
  data: T;
  message?: string;
  status: string;
}

export interface PaginatedResponse<T> {
  items: T[];
  total: number;
  page: number;
  size: number;
  pages: number;
}

export interface PaginationParams {
  page?: number;
  size?: number;
}

export interface FilterParams {
  [key: string]: string | number | boolean | undefined;
}

export interface QueryParams extends PaginationParams, FilterParams {}


