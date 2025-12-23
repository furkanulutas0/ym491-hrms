import { useMutation } from '@tanstack/react-query';
import { aiApi, AIRequest, JobAssistRequest } from '../api/ai-api';

export const useGenerateContent = () => {
  return useMutation({
    mutationFn: (data: AIRequest) => aiApi.generateContent(data),
  });
};

export const useAssistJobPosting = () => {
  return useMutation({
    mutationFn: (data: JobAssistRequest) => aiApi.assistJobPosting(data),
  });
};

