class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :listing_tags, dependent: :destroy
	has_many :tags, through: :listing_tags
	has_many :reservations, dependent: :destroy
	has_many :available_dates, dependent: :destroy

	mount_uploaders :photos, AvatarUploader

  filterrific(
    default_filter_params: { search_query: '' },
    available_filters: [
      :search_query,
      :with_tag_id
    ]
  )

	scope :search_query, lambda { |query|
	  return nil if query.blank?

	  terms = query.downcase.split(/\s+/)

	  terms = terms.map { |e|
	    (e.gsub('*', '%') + '%').gsub(/%+/, '%')
	  }

	  num_or_conds = 2
	  where(
	    terms.map { |term|
	      "(LOWER(listings.title) LIKE ? OR LOWER(listings.location) LIKE ?)"
	    }.join(' AND '),
	    *terms.map { |e| [e] * num_or_conds }.flatten
	  )
	}

  scope :with_tag_id, lambda { |tag_ids|
    joins(:tags).where(tags: {id: tag_ids}).uniq
  }

end