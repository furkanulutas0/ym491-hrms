import { useQuery, UseQueryOptions } from '@tanstack/react-query';
import { useUrlParams } from './use-url-params';
import { PaginatedResponse } from '@/types/api';

export function usePaginatedQuery<TData = unknown, TError = unknown>(
  key: string[],
  fetcher: (params: any) => Promise<PaginatedResponse<TData>>,
  options?: Omit<UseQueryOptions<PaginatedResponse<TData>, TError>, 'queryKey' | 'queryFn'>
) {
  const { getParam } = useUrlParams();
  const page = Number(getParam('page')) || 1;
  const size = Number(getParam('size')) || 10;
  
  // You can also extract sort/filter params here dynamically if needed

  return useQuery<PaginatedResponse<TData>, TError>({
    queryKey: [...key, page, size],
    queryFn: () => fetcher({ page, size }),
    ...options,
  });
}





