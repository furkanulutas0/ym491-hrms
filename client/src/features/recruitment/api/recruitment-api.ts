import { api } from '@/lib/api';
import { JobPosting, JobApplication } from '../types';

export const recruitmentApi = {
  getJob: async (id: number): Promise<JobPosting> => {
    // Using the base service API directly
    const response = await api.get<JobPosting>(`/api/base/recruitment/jobs/${id}`);
    return response as unknown as JobPosting;
  },

  getAllJobs: async (): Promise<JobPosting[]> => {
    const response = await api.get<JobPosting[]>('/api/base/recruitment/jobs');
    return response as unknown as JobPosting[];
  },

  getJobApplications: async (jobId: number, status?: string): Promise<JobApplication[]> => {
    const params = status ? { status } : {};
    const response = await api.get<JobApplication[]>(`/api/base/recruitment/jobs/${jobId}/applications`, { params });
    return response as unknown as JobApplication[];
  }
};

