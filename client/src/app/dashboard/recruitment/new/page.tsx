import JobPostingForm from "@/components/recruitment/JobPostingForm";

export default function NewJobPage() {
  return (
    <div className="flex flex-col gap-8">
      <div className="flex flex-col gap-1">
        <h1 className="text-3xl font-bold tracking-tight text-text-primary-light dark:text-text-primary-dark">
          Create Job Posting
        </h1>
        <p className="text-text-secondary-light dark:text-text-secondary-dark text-base font-normal">
          Create a new job opportunity and define requirements for AI candidate matching.
        </p>
      </div>

      <JobPostingForm />
    </div>
  );
}

