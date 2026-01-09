import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { candidateApi } from '../api/candidate-api';
import type {
  CandidateRegisterData,
  CandidateLoginData,
  CandidateProfileUpdate
} from '../types';

// ============ Auth Hooks ============

export const useCandidateProfile = () => {
  return useQuery({
    queryKey: ['candidate', 'me'],
    queryFn: candidateApi.getMe,
    retry: false,
    staleTime: 1000 * 60 * 5, // 5 minutes
  });
};

export const useCandidateRegister = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: (data: CandidateRegisterData) => candidateApi.register(data),
    onSuccess: (data) => {
      // Store token
      if (typeof window !== 'undefined') {
        localStorage.setItem('candidate_token', data.access_token);
      }
      // Update cache
      queryClient.setQueryData(['candidate', 'me'], data.candidate);
    },
  });
};

export const useCandidateLogin = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: (data: CandidateLoginData) => candidateApi.login(data),
    onSuccess: (data) => {
      // Store token
      if (typeof window !== 'undefined') {
        localStorage.setItem('candidate_token', data.access_token);
      }
      // Update cache
      queryClient.setQueryData(['candidate', 'me'], data.candidate);
    },
  });
};

export const useCandidateLogout = () => {
  const queryClient = useQueryClient();
  
  return () => {
    // Clear token
    if (typeof window !== 'undefined') {
      localStorage.removeItem('candidate_token');
    }
    // Clear cache
    queryClient.setQueryData(['candidate', 'me'], null);
    queryClient.invalidateQueries({ queryKey: ['candidate'] });
  };
};

export const useForgotPassword = () => {
  return useMutation({
    mutationFn: (email: string) => candidateApi.forgotPassword(email),
  });
};

export const useResetPassword = () => {
  return useMutation({
    mutationFn: ({ token, newPassword }: { token: string; newPassword: string }) =>
      candidateApi.resetPassword(token, newPassword),
  });
};

export const useUpdateCandidateProfile = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: (data: CandidateProfileUpdate) => candidateApi.updateProfile(data),
    onSuccess: (data) => {
      queryClient.setQueryData(['candidate', 'me'], data);
      queryClient.invalidateQueries({ queryKey: ['candidate', 'profile'] });
    },
  });
};

