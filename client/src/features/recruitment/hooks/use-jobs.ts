import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { recruitmentApi } from '../api/recruitment-api';
import { JobPostingCreate } from '../types';

export const useJob = (id: number) => {
  return useQuery({
    queryKey: ['job', id],
    queryFn: () => recruitmentApi.getJob(id),
    enabled: !!id,
    retry: false,
  });
};

export const useJobs = () => {
  return useQuery({
    queryKey: ['jobs'],
    queryFn: () => recruitmentApi.getAllJobs(),
  });
};

export const useCreateJob = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: (data: JobPostingCreate) => recruitmentApi.createJob(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['jobs'] });
    },
  });
};

export const useUpdateJob = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: ({ id, data }: { id: number; data: Partial<JobPostingCreate> }) => 
      recruitmentApi.updateJob(id, data),
    onSuccess: (data) => {
      queryClient.invalidateQueries({ queryKey: ['jobs'] });
      queryClient.invalidateQueries({ queryKey: ['job', data.id] });
    },
  });
};
