import { usePathname, useRouter, useSearchParams } from 'next/navigation';
import { useCallback } from 'react';

export function useUrlParams() {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();

  const createQueryString = useCallback(
    (name: string, value: string) => {
      const params = new URLSearchParams(searchParams.toString());
      params.set(name, value);
      return params.toString();
    },
    [searchParams]
  );

  const setParam = (name: string, value: string | number | null) => {
    const params = new URLSearchParams(searchParams.toString());
    if (value === null || value === '') {
      params.delete(name);
    } else {
      params.set(name, String(value));
    }
    router.push(pathname + '?' + params.toString());
  };

  const getParam = (name: string) => {
    return searchParams.get(name);
  };

  return {
    searchParams,
    setParam,
    getParam,
    createQueryString,
  };
}





