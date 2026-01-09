import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { pipelineApi } from '../api/pipeline-api';
import { DocumentReviewRequest } from '../types';

// Query key factory
const documentReviewKeys = {
  all: ['documentReview'] as const,
  forApplication: (appId: number) => [...documentReviewKeys.all, 'application', appId] as const,
};

/**
 * Hook to fetch documents for review with candidate CV info
 */
export function useDocumentsForReview(appId: number) {
  return useQuery({
    queryKey: documentReviewKeys.forApplication(appId),
    queryFn: () => pipelineApi.getDocumentsForReview(appId),
    enabled: !!appId,
    staleTime: 30000, // 30 seconds
  });
}

/**
 * Hook to review (approve/reject) a document
 */
export function useReviewDocument() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: ({
      appId,
      docId,
      review,
    }: {
      appId: number;
      docId: number;
      review: DocumentReviewRequest;
    }) => pipelineApi.reviewDocument(appId, docId, review),
    onSuccess: (_, variables) => {
      // Invalidate the documents for review query to refresh the data
      queryClient.invalidateQueries({
        queryKey: documentReviewKeys.forApplication(variables.appId),
      });
      // Also invalidate pipeline queries to update the stage view
      queryClient.invalidateQueries({
        queryKey: ['pipeline'],
      });
    },
  });
}

