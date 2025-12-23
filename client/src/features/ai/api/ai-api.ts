import { api } from '@/lib/api';

export interface AIRequest {
  prompt: string;
  task_type?: 'chat' | 'summarization' | 'generic';
  parameters?: Record<string, any>;
}

export interface AIResponse {
  content: string;
  metadata?: Record<string, any>;
}

export interface JobAssistRequest {
  title: string;
  department?: string | null;
  location?: string | null;
  work_type?: string | null;
  description?: string | null;
  responsibilities?: string[] | null;
  requirements?: string[] | null;
  benefits?: string[] | null;
}

export interface JobAssistResponse {
  title: string;
  department: string | null;
  location: string | null;
  work_type: string | null;
  description: string | null;
  responsibilities: string[];
  requirements: string[];
  benefits: string[];
  [key: string]: any;
}

export const aiApi = {
  generateContent: async (data: AIRequest): Promise<AIResponse> => {
    const response = await api.post<AIResponse>('/api/ai/generate', data);
    return response as unknown as AIResponse;
  },

  assistJobPosting: async (data: JobAssistRequest): Promise<JobAssistResponse> => {
    const response = await api.post<JobAssistResponse>('/api/ai/generate/job-assist', data);
    return response as unknown as JobAssistResponse;
  },
};

