import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { authApi } from '../api/auth-api';
import { LoginInput, RegisterInput } from '../schemas';
import { useRouter } from 'next/navigation';

export const useLogin = () => {
  const router = useRouter();
  
  return useMutation({
    mutationFn: (data: LoginInput) => authApi.login(data),
    onSuccess: (data) => {
      localStorage.setItem('token', data.access_token);
      // Redirect or update state
      router.push('/dashboard');
    },
  });
};

export const useRegister = () => {
  const router = useRouter();

  return useMutation({
    mutationFn: (data: RegisterInput) => authApi.register(data),
    onSuccess: (data) => {
      localStorage.setItem('token', data.access_token);
      router.push('/dashboard');
    },
  });
};

export const useUser = () => {
  return useQuery({
    queryKey: ['user', 'me'],
    queryFn: authApi.me,
    retry: false,
  });
};


